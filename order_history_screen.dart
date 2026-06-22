// lib/screens/order_history_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth_provider.dart';
import '../theme.dart';
import 'order_detail_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<Map<String, dynamic>> _orders = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final auth = context.read<AuthProvider>();
    final userId = auth.user?.id;

    if (userId == null) {
      setState(() {
        _loading = false;
        _error = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final db = FirebaseFirestore.instance;

      final snap = await db
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      setState(() {
        _orders = snap.docs.map((doc) {
          final data = doc.data();
          data['orderId'] = doc.id;
          return data;
        }).toList();
        _loading = false;
      });
    } catch (e) {
      debugPrint('Load orders error: $e');
      setState(() {
        _loading = false;
        // Surface the real error so it's obvious what's wrong
        // (most commonly: missing Firestore composite index)
        _error = e.toString();
      });
    }
  }

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
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

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
            icon: const Icon(Icons.arrow_back_ios_new,
                color: kForeground, size: 18),
            onPressed: () => Navigator.pop(context)),
        title: Text('My Orders',
            style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kPrimary,
                fontStyle: FontStyle.italic)),
      ),
      body: !auth.isLoggedIn
          ? _buildNotLoggedIn()
          : _loading
              ? const Center(child: CircularProgressIndicator(color: kPrimary))
              : _error != null
                  ? _buildError()
                  : _orders.isEmpty
                      ? _buildEmpty()
                      : _buildOrderList(),
    );
  }

  Widget _buildError() {
    final isIndexError = _error!.contains('failed-precondition') ||
        _error!.toLowerCase().contains('index');
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                color: kSecondary, shape: BoxShape.circle),
            child: const Icon(Icons.error_outline,
                size: 40, color: Color(0xFFDC2626)),
          ),
          const SizedBox(height: 20),
          Text(
            isIndexError ? 'Setup Required' : 'Something Went Wrong',
            style: GoogleFonts.playfairDisplay(
                fontSize: 22, fontWeight: FontWeight.w700, color: kForeground),
          ),
          const SizedBox(height: 8),
          Text(
            isIndexError
                ? 'Firestore needs a composite index for this query. Check the debug console for a link to create it automatically.'
                : 'We could not load your orders. Please try again.',
            style: GoogleFonts.dmSans(fontSize: 13, color: kMutedFg),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _loadOrders,
              child: Text('Retry', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildNotLoggedIn() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                const BoxDecoration(color: kSecondary, shape: BoxShape.circle),
            child: const Icon(Icons.lock_outline, size: 40, color: kMutedFg),
          ),
          const SizedBox(height: 20),
          Text('Login Required',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kForeground)),
          const SizedBox(height: 8),
          Text('Please log in to see your order history.',
              style: GoogleFonts.dmSans(fontSize: 13, color: kMutedFg),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                const BoxDecoration(color: kSecondary, shape: BoxShape.circle),
            child: const Icon(Icons.receipt_long_outlined,
                size: 40, color: kMutedFg),
          ),
          const SizedBox(height: 20),
          Text('No Orders Yet',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: kForeground)),
          const SizedBox(height: 8),
          Text('Your order history will appear here once you place an order.',
              style: GoogleFonts.dmSans(fontSize: 13, color: kMutedFg),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }

  Widget _buildOrderList() {
    return RefreshIndicator(
      color: kPrimary,
      onRefresh: _loadOrders,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final order = _orders[i];
          final status = (order['status'] ?? 'pending').toString();
          final items = (order['items'] as List<dynamic>?) ?? [];
          final address = order['address'] as Map<String, dynamic>?;
          final orderId = order['orderId'] as String;

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OrderDetailScreen(order: order),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: kBorder)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order #${orderId.substring(0, 8)}',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: kForeground)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                                color: _statusColor(status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color:
                                        _statusColor(status).withOpacity(0.3))),
                            child: Text(
                                status.isNotEmpty
                                    ? status[0].toUpperCase() +
                                        status.substring(1)
                                    : status,
                                style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: _statusColor(status))),
                          ),
                        ]),
                    const SizedBox(height: 4),
                    if (order['createdAt'] != null)
                      Text(_formatDate(order['createdAt']),
                          style:
                              GoogleFonts.dmSans(fontSize: 11, color: kMutedFg)),
                    const SizedBox(height: 8),
                    Text(
                        'R ${(order['totalAmount'] ?? order['total'] ?? 0).toStringAsFixed(0)}',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: kPrimary)),
                    if (items.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                          '${items.length} item${items.length > 1 ? 's' : ''}: ${items.take(2).map((i) => i['name']).join(', ')}${items.length > 2 ? '...' : ''}',
                          style:
                              GoogleFonts.dmSans(fontSize: 11, color: kMutedFg),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                    if (address != null) ...[
                      const SizedBox(height: 4),
                      Text(
                          'Delivery to: ${address['street'] ?? ''}, ${address['city'] ?? ''}',
                          style:
                              GoogleFonts.dmSans(fontSize: 11, color: kMutedFg),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('View Details',
                            style: GoogleFonts.dmSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: kPrimary)),
                        const Icon(Icons.chevron_right,
                            size: 16, color: kPrimary),
                      ],
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}