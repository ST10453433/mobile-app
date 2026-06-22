// lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/auth_provider.dart';
import '../providers/store_provider.dart';
import '../theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _step = 0;

  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addrCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();
  final _promoCtrl = TextEditingController();

  String _province = 'Gauteng';
  double _discountPct = 0;
  String? _promoMsg;
  bool _placing = false;
  String? _orderId;

  final List<String> _provinces = [
    'Gauteng',
    'Western Cape',
    'KwaZulu-Natal',
    'Eastern Cape',
    'Limpopo',
    'Mpumalanga',
    'North West',
    'Free State',
    'Northern Cape',
  ];

  final Map<String, double> _promoCodes = {
    'WANGA10': 10,
    'PURSE20': 20,
    'NEWCLIENT': 15,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<AuthProvider>().user;
      if (user != null) {
        _nameCtrl.text = user.name;
        _phoneCtrl.text = user.phone ?? '';
        _addrCtrl.text = user.address ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addrCtrl.dispose();
    _cityCtrl.dispose();
    _postalCtrl.dispose();
    _promoCtrl.dispose();
    super.dispose();
  }

  double get _subtotal => context.read<StoreProvider>().cartTotal;
  double get _discount => _subtotal * (_discountPct / 100);
  double get _total => _subtotal - _discount;

  // ── Apply promo code locally ──
  void _applyPromo() {
    final code = _promoCtrl.text.trim().toUpperCase();
    if (code.isEmpty) return;

    if (_promoCodes.containsKey(code)) {
      setState(() {
        _discountPct = _promoCodes[code]!;
        _promoMsg = '✓ ${_discountPct.toInt()}% discount applied!';
      });
    } else {
      setState(() {
        _discountPct = 0;
        _promoMsg = 'Invalid promo code. Try WANGA10, PURSE20, or NEWCLIENT';
      });
    }
  }

  // ── Save order to Firestore ──
  Future<void> _placeOrder() async {
    final store = context.read<StoreProvider>();
    final auth = context.read<AuthProvider>();

    // Validate fields
    if (_nameCtrl.text.trim().isEmpty ||
        _phoneCtrl.text.trim().isEmpty ||
        _addrCtrl.text.trim().isEmpty ||
        _cityCtrl.text.trim().isEmpty) {
      _showSnack('Please fill in all delivery details', error: true);
      return;
    }

    setState(() => _placing = true);

    try {
      final db = FirebaseFirestore.instance;

      // Build the order document
      final orderData = {
        'userId': auth.user?.id ?? 'guest',
        'customerName': _nameCtrl.text.trim(),
        'email': auth.user?.email ?? '',
        'phone': _phoneCtrl.text.trim(),
        'address': {
          'street': _addrCtrl.text.trim(),
          'city': _cityCtrl.text.trim(),
          'postalCode': _postalCtrl.text.trim(),
          'province': _province,
        },
        'items': store.cart
            .map((i) => {
                  'productId': i.product.id,
                  'name': i.product.name,
                  'price': i.product.price,
                  'quantity': i.quantity,
                  'imageUrl': i.product.image,
                })
            .toList(),
        'subtotal': _subtotal,
        'discount': _discount,
        'totalAmount': _total,
        'promoCode': _discountPct > 0 ? _promoCtrl.text.trim() : null,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save to Firestore orders collection
      final ref = await db.collection('orders').add(orderData);

      // Clear the cart
      store.clearCart();

      setState(() {
        _orderId = ref.id;
        _placing = false;
        _step = 2;
      });
    } catch (e) {
      setState(() => _placing = false);
      _showSnack('Could not place order. Please try again.', error: true);
      debugPrint('Order error: $e');
    }
  }

  void _showSnack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.dmSans()),
      backgroundColor: error ? const Color(0xFFDC2626) : kPrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: kBorder),
        ),
        leading: _step == 2
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: kForeground, size: 18),
                onPressed: () {
                  if (_step == 0) {
                    Navigator.pop(context);
                  } else {
                    setState(() => _step--);
                  }
                },
              ),
        title: Text(
          _step == 0
              ? 'Delivery Details'
              : _step == 1
                  ? 'Order Summary'
                  : 'Order Placed!',
          style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kPrimary,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: _step == 0
          ? _buildDeliveryStep()
          : _step == 1
              ? _buildSummaryStep()
              : _buildConfirmStep(),
    );
  }

  // ═══ STEP 1 — DELIVERY DETAILS ═══
  Widget _buildDeliveryStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label('Full Name'),
        _field(_nameCtrl, 'Your full name', Icons.person_outline),
        const SizedBox(height: 16),
        _label('Phone Number'),
        _field(_phoneCtrl, '+27 ...', Icons.phone_outlined,
            type: TextInputType.phone),
        const SizedBox(height: 16),
        _label('Street Address'),
        _field(_addrCtrl, '123 Main Street', Icons.home_outlined),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _label('City'),
              _field(_cityCtrl, 'Johannesburg', Icons.location_city_outlined),
            ]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _label('Postal Code'),
              _field(_postalCtrl, '2000', Icons.markunread_mailbox_outlined,
                  type: TextInputType.number),
            ]),
          ),
        ]),
        const SizedBox(height: 16),
        _label('Province'),
        Container(
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorder),
          ),
          child: DropdownButtonFormField<String>(
            value: _province,
            dropdownColor: kCard,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            items: _provinces
                .map((p) => DropdownMenuItem(
                    value: p,
                    child: Text(p, style: GoogleFonts.dmSans(fontSize: 14))))
                .toList(),
            onChanged: (v) => setState(() => _province = v!),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              if (_nameCtrl.text.trim().isEmpty ||
                  _addrCtrl.text.trim().isEmpty ||
                  _cityCtrl.text.trim().isEmpty) {
                _showSnack('Please fill in all fields', error: true);
                return;
              }
              setState(() => _step = 1);
            },
            child: Text('Continue to Summary',
                style: GoogleFonts.dmSans(
                    fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ),
      ]),
    );
  }

  // ═══ STEP 2 — ORDER SUMMARY ═══
  Widget _buildSummaryStep() {
    final store = context.watch<StoreProvider>();
    return ListView(padding: const EdgeInsets.all(16), children: [
      Text('Your Items (${store.cartCount})',
          style: GoogleFonts.dmSans(
              fontSize: 13, fontWeight: FontWeight.w700, color: kPrimary)),
      const SizedBox(height: 12),

      // Cart items
      ...store.cart.map((item) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorder)),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Image.network(item.product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                          color: kSecondary,
                          child: const Icon(Icons.shopping_bag_outlined,
                              color: kPrimary, size: 20))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: kForeground)),
                    Text('Qty: ${item.quantity}',
                        style:
                            GoogleFonts.dmSans(fontSize: 11, color: kMutedFg)),
                  ])),
              Text(
                  'R ${(item.product.price * item.quantity).toStringAsFixed(0)}',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: kPrimary)),
            ]),
          )),

      const SizedBox(height: 16),

      // Promo code
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorder)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Promo Code',
              style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: kForeground)),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
                child: TextField(
              controller: _promoCtrl,
              style: GoogleFonts.dmSans(fontSize: 13),
              decoration: const InputDecoration(
                  hintText: 'Enter promo code',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
            )),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: _applyPromo,
                child: Text('Apply',
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.w600))),
          ]),
          if (_promoMsg != null) ...[
            const SizedBox(height: 6),
            Text(_promoMsg!,
                style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: _discountPct > 0
                        ? Colors.green.shade700
                        : const Color(0xFFDC2626))),
          ],
        ]),
      ),

      const SizedBox(height: 16),

      // Totals
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorder)),
        child: Column(children: [
          _totalRow('Subtotal', 'R ${_subtotal.toStringAsFixed(0)}'),
          if (_discountPct > 0)
            _totalRow('Discount (${_discountPct.toInt()}%)',
                '− R ${_discount.toStringAsFixed(0)}',
                color: Colors.green.shade700),
          _totalRow('Shipping', 'Free', color: kPrimary),
          const Divider(color: kBorder, height: 20),
          _totalRow('Total', 'R ${_total.toStringAsFixed(0)}', bold: true),
        ]),
      ),

      const SizedBox(height: 24),

      SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: _placing ? null : _placeOrder,
          child: _placing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : Text('Place Order',
                  style: GoogleFonts.dmSans(
                      fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ),
      const SizedBox(height: 32),
    ]);
  }

  // ═══ STEP 3 — CONFIRMATION ═══
  Widget _buildConfirmStep() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                const BoxDecoration(color: kSecondary, shape: BoxShape.circle),
            child: const Icon(Icons.check_circle_outline,
                size: 48, color: kPrimary),
          ),
          const SizedBox(height: 24),
          Text('Order Placed! 🎉',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: kForeground)),
          const SizedBox(height: 12),
          Text(
              'Thank you for your order. We\'ll get it to you within 3–5 business days.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(fontSize: 14, color: kMutedFg)),
          if (_orderId != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: kSecondary, borderRadius: BorderRadius.circular(8)),
              child: Text('Order ID: ${_orderId!.substring(0, 8)}...',
                  style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: kPrimary,
                      fontWeight: FontWeight.w600)),
            ),
          ],
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: Text('Continue Shopping',
                  style: GoogleFonts.dmSans(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: GoogleFonts.dmSans(
                fontSize: 13, fontWeight: FontWeight.w600, color: kForeground)),
      );

  Widget _field(TextEditingController ctrl, String hint, IconData icon,
          {TextInputType type = TextInputType.text}) =>
      TextField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: kMutedFg, size: 20),
        ),
      );

  Widget _totalRow(String label, String value,
          {Color? color, bool bold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: color ?? kMutedFg,
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w400)),
          Text(value,
              style: GoogleFonts.dmSans(
                  fontSize: bold ? 15 : 13,
                  color: color ?? (bold ? kForeground : kMutedFg),
                  fontWeight: bold ? FontWeight.w700 : FontWeight.w400)),
        ]),
      );
}
