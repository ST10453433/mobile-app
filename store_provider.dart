// lib/providers/store_provider.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class StoreProvider extends ChangeNotifier {
  final List<CartItem> _cart = [];
  final List<Product> _wishlist = [];

  List<CartItem> get cart => List.unmodifiable(_cart);
  List<Product> get wishlist => List.unmodifiable(_wishlist);

  int get cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotal =>
      _cart.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  String get formattedCartTotal => 'R ${cartTotal.toStringAsFixed(0)}';

  // ── Cart ────────────────────────────────────────────────────
  bool isInCart(String id) => _cart.any((i) => i.product.id == id);

  void addToCart(Product product) {
    final idx = _cart.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      _cart[idx].quantity++;
    } else {
      _cart.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cart.removeWhere((i) => i.product.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int qty) {
    if (qty <= 0) {
      removeFromCart(id);
      return;
    }
    final idx = _cart.indexWhere((i) => i.product.id == id);
    if (idx >= 0) {
      _cart[idx].quantity = qty;
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // ── Wishlist ─────────────────────────────────────────────────
  bool isInWishlist(String id) => _wishlist.any((p) => p.id == id);

  void toggleWishlist(Product product) {
    if (isInWishlist(product.id)) {
      _wishlist.removeWhere((p) => p.id == product.id);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }

  void removeFromWishlist(String id) {
    _wishlist.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
