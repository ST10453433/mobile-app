// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import 'main_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = allProducts.where((p) => p.featured).take(4).toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroSection(),
          _AboutSection(),
          _FeaturedSection(products: featured),
          _FeaturesStrip(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Hero ────────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFCE4EC), Color(0xFFFDF2F4)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: kBorder),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.auto_awesome, size: 12, color: kPrimary),
              const SizedBox(width: 5),
              Text(
                'Premium Quality Collections',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: kForeground,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 14),

          // Headline
          RichText(
            text: TextSpan(
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: kForeground,
                height: 1.2,
              ),
              children: const [
                TextSpan(text: 'Crafting Your\n'),
                TextSpan(
                  text: 'Statement.',
                  style: TextStyle(color: kPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Curated premium handbags & authentic luxurious weaves — express your unique Purseonality.',
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: kMutedFg,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 16),

          // CTA buttons
          Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context
                    .findAncestorStateOfType<MainScaffoldState>()
                    ?.goToTab(1),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Shop Purses',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => context
                    .findAncestorStateOfType<MainScaffoldState>()
                    ?.goToTab(2),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Shop Weaves',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

// ─── About ───────────────────────────────────────────────────────────────────
class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kCard,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF8BBD9), Color(0xFFFCE4EC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              // Replace with: Image.asset('assets/images/wanga_photo.jpg', fit: BoxFit.cover)
              child: const Center(
                  child: Icon(Icons.person, size: 36, color: kPrimary)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABOUT',
                  style: GoogleFonts.dmSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: kPrimary,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Meet Wanga',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kForeground,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Hi, I'm Wanga Mammburu — a Wits University student and founder of Purseonality. "
                  "Premium accessories for every woman.",
                  style: GoogleFonts.dmSans(
                      fontSize: 11, color: kMutedFg, height: 1.55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Featured ────────────────────────────────────────────────────────────────
class _FeaturedSection extends StatelessWidget {
  final List<Product> products;
  const _FeaturedSection({required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FEATURED',
            style: GoogleFonts.dmSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: kPrimary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: kForeground,
              ),
              children: const [
                TextSpan(text: 'Top '),
                TextSpan(text: 'Picks', style: TextStyle(color: kPrimary)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Fixed-height grid so cards are compact
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, i) => ProductCard(
              product: products[i],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: products[i]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Features strip ──────────────────────────────────────────────────────────
class _FeaturesStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.local_shipping_outlined,
        'title': 'Free Shipping',
        'sub': 'Across South Africa',
      },
      {
        'icon': Icons.verified_outlined,
        'title': '100% Authentic',
        'sub': 'Genuine products only',
      },
      {
        'icon': Icons.support_agent_outlined,
        'title': '24/7 Support',
        'sub': 'Always here to help',
      },
      {
        'icon': Icons.lock_outline,
        'title': 'Secure Payments',
        'sub': 'PayFast protected',
      },
    ];
    return Container(
      color: kSecondary.withOpacity(0.4),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2.6,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorder),
            ),
            child: Row(children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: kSecondary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child:
                    Icon(item['icon'] as IconData, size: 15, color: kPrimary),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: kForeground,
                      ),
                    ),
                    Text(
                      item['sub'] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 9,
                        color: kMutedFg,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
