// lib/services/api_service.dart
// Backend API calls — demo mode until Next.js backend is deployed.

class ApiService {
  static const String baseUrl = 'https://purseonality.vercel.app/api';

  static Future<Map<String, dynamic>> getOrders(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {'success': true, 'orders': []};
  }

  static Future<Map<String, dynamic>> createOrder({
    required String token,
    required List<Map<String, dynamic>> items,
    required String address,
    required double total,
    String? promoCode,
    String? deliveryMethod,
    String? paxiPoint,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return {
      'success': true,
      'orderId': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
    };
  }

  static Future<Map<String, dynamic>> initiatePayment({
    required String token,
    required String orderId,
    required double amount,
    required String customerName,
    required String customerEmail,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'success': true,
      'paymentUrl': 'https://sandbox.payfast.co.za/eng/process',
    };
  }

  static Future<Map<String, dynamic>> validatePromo(String code) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (code.toUpperCase() == 'PURSE20') {
      return {'success': true, 'discountPercent': 20};
    }
    return {'success': false, 'message': 'Invalid promo code'};
  }
}
