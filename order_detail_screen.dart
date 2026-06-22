// lib/screens/order_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailScreen({super.key, required this.order});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return kMutedFg;
    }
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return '';
    try {
      final dt = (timestamp as Timestamp).toDate();
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final hour = dt.hour.toString().padLeft(2, '0');
      final min = dt.minute.toString().padLeft(2, '0');
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}, $hour:$min';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderId = order['orderId'] as String? ?? '';
    final status = (order['status'] ?? 'pending').toString();
    final items = (order['items'] as List<dynamic>?) ?? [];
    final address = order['address'] as Map<String, dynamic>?;
    final subtotal = (order['subtotal'] ?? 0).toDouble();
    final discount = (order['discount'] ?? 0).toDouble();
    final total = (order['totalAmount'] ?? order['total'] ?? 0).toDouble();
    final promoCode = order['promoCode'] as String?;
    final customerName = order['customerName'] as String? ?? '';
    final phone = order['phone'] as String? ?? '';
    final email = order['email'] as String? ?? '';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kForeground, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Order Details',
            style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kPrimary,
                fontStyle: FontStyle.italic)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header card: order id + status + date
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${orderId.length >= 8 ? orderId.substring(0, 8) : orderId}',
                      style: GoogleFonts.dmSans(
                          fontSize: 15, fontWeight: FontWeight.w700, color: kForeground),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: _statusColor(status).withOpacity(0.3)),
                      ),
                      child: Text(
                        status.isNotEmpty ? status[0].toUpperCase() + status.substring(1) : status,
                        style: GoogleFonts.dmSans(
                            fontSize: 11, fontWeight: FontWeight.w700, color: _statusColor(status)),
                      ),
                    ),
                  ],
                ),
                if (order['createdAt'] != null) ...[
                  const SizedBox(height: 6),
                  Text(_formatDate(order['createdAt']),
                      style: GoogleFonts.dmSans(fontSize: 12, color: kMutedFg)),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Items
          Text('Items (${items.length})',
              style: GoogleFonts.dmSans(
                  fontSize: 13, fontWeight: FontWeight.w700, color: kPrimary)),
          const SizedBox(height: 10),
          ...items.map((raw) {
            final item = raw as Map<String, dynamic>;
            final name = item['name'] ?? '';
            final qty = item['quantity'] ?? 1;
            final price = (item['price'] ?? 0).toDouble();
            final imageUrl = item['imageUrl'] as String?;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorder),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: imageUrl != null && imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: kSecondary,
                                child: const Icon(Icons.shopping_bag_outlined,
                                    color: kPrimary, size: 20),
                              ),
                            )
                          : Container(
                              color: kSecondary,
                              child: const Icon(Icons.shopping_bag_outlined,
                                  color: kPrimary, size: 20),
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: GoogleFonts.dmSans(
                                fontSize: 13, fontWeight: FontWeight.w600, color: kForeground)),
                        const SizedBox(height: 2),
                        Text('Qty: $qty  •  R ${price.toStringAsFixed(0)} each',
                            style: GoogleFonts.dmSans(fontSize: 11, color: kMutedFg)),
                      ],
                    ),
                  ),
                  Text('R ${(price * (qty as num)).toStringAsFixed(0)}',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 14, fontWeight: FontWeight.w700, color: kPrimary)),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // Totals
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorder),
            ),
            child: Column(
              children: [
                _row('Subtotal', 'R ${subtotal.toStringAsFixed(0)}'),
                if (discount > 0)
                  _row(
                    'Discount${promoCode != null ? ' ($promoCode)' : ''}',
                    '− R ${discount.toStringAsFixed(0)}',
                    color: Colors.green.shade700,
                  ),
                _row('Shipping', 'Free', color: kPrimary),
                const Divider(color: kBorder, height: 20),
                _row('Total', 'R ${total.toStringAsFixed(0)}', bold: true),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Delivery details
          Text('Delivery Details',
              style: GoogleFonts.dmSans(
                  fontSize: 13, fontWeight: FontWeight.w700, color: kPrimary)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (customerName.isNotEmpty) _infoLine(Icons.person_outline, customerName),
                if (phone.isNotEmpty) _infoLine(Icons.phone_outlined, phone),
                if (email.isNotEmpty) _infoLine(Icons.email_outlined, email),
                if (address != null)
                  _infoLine(
                    Icons.location_on_outlined,
                    '${address['street'] ?? ''}, ${address['city'] ?? ''}'
                    '${(address['postalCode'] ?? '').toString().isNotEmpty ? ', ${address['postalCode']}' : ''}'
                    '${(address['province'] ?? '').toString().isNotEmpty ? ', ${address['province']}' : ''}',
                  ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _infoLine(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: kMutedFg),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  style: GoogleFonts.dmSans(fontSize: 13, color: kForeground)),
            ),
          ],
        ),
      );

  Widget _row(String label, String value, {Color? color, bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
          ],
        ),
      );
}