// lib/services/share_service.dart
// pubspec.yaml — add: share_plus: ^10.0.0

import 'package:share_plus/share_plus.dart';
import '../models/product.dart';

class ShareService {
  ShareService._();
  static final ShareService instance = ShareService._();

  Future<void> shareProduct(Product product) async {
    await Share.share(
      '👛 Check out ${product.name} on Purseonality!\n\n'
      '${product.description}\n\n'
      '💰 Only ${product.formattedPrice}\n'
      '🚚 Free shipping across South Africa\n\n'
      'Shop now: https://purseonality.vercel.app\n\n'
      '#Purseonality #Fashion #SouthAfrica',
      subject: '${product.name} — Purseonality',
    );
  }

  Future<void> shareApp() async {
    await Share.share(
      '💅 I just found the most amazing bags and weaves on Purseonality!\n\n'
      'Premium quality, free shipping across SA.\n\n'
      'Shop here: https://purseonality.vercel.app\n\n'
      '#Purseonality #SouthAfrica #Fashion',
      subject: 'Purseonality — Premium Bags & Weaves',
    );
  }
}
