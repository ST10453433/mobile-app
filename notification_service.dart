// lib/services/notification_service.dart
import 'package:flutter/material.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<void> init() async {
    // No native setup needed
  }

  void _show(String title, String body) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Colors.white)),
            Text(body,
                style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        backgroundColor: const Color(0xFFE91E63),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void notifyOrderConfirmed(String orderId) =>
      _show('🎉 Order Confirmed!', 'Order #$orderId placed successfully.');

  void notifyOrderShipped(String orderId) =>
      _show('📦 On the way!', 'Order #$orderId has been shipped.');

  void notifyWelcome(String name) =>
      _show('Welcome, $name! 👛', 'Discover premium bags and weaves.');
}
