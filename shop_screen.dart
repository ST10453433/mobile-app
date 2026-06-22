// lib/screens/shop_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ShopScreen extends StatefulWidget {
  final String initialCategory;
  const ShopScreen({super.key, required this.initialCategory});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late String _selectedCategory;
  String _sortBy = 'featured';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  List<Product> get _filtered {
    var list =
        allProducts.where((p) => p.category == _selectedCategory).toList();
    if (_sortBy == 'price-asc') list.sort((a, b) => a.price.compareTo(b.price));
    if (_sortBy == 'price-desc')
      list.sort((a, b) => b.price.compareTo(a.price));
    if (_sortBy == 'featured')
      list.sort((a, b) => (b.featured ? 1 : 0) - (a.featured ? 1 : 0));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // ── Banner ─────────────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _selectedCategory == 'weaves'
                    ? [const Color(0xFFF8BBD9), kAccent.withOpacity(0.6)]
                    : [const Color(0xFFFCE4EC), kPrimary.withOpacity(0.4)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _selectedCategory == 'weaves'
                        ? Icons.content_cut
                        : Icons.shopping_bag,
                    size: 26,
                    color: kPrimary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _selectedCategory == 'weaves'
                        ? 'Shop Weaves'
                        : 'Shop Purses',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kForeground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedCategory == 'weaves'
                        ? 'Authentic, luxurious hair weaves'
                        : 'Premium handbags for every occasion',
                    style: GoogleFonts.dmSans(fontSize: 11, color: kMutedFg),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Category tabs ──────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Container(
            color: kCard,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              Expanded(
                child: _CategoryTab(
                  label: 'Purses',
                  icon: Icons.shopping_bag_outlined,
                  selected: _selectedCategory == 'purses',
                  onTap: () => setState(() => _selectedCategory = 'purses'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CategoryTab(
                  label: 'Weaves',
                  icon: Icons.content_cut_outlined,
                  selected: _selectedCategory == 'weaves',
                  onTap: () => setState(() => _selectedCategory = 'weaves'),
                ),
              ),
            ]),
          ),
        ),

        // ── Sort bar ───────────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Container(
            color: kBackground,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(children: [
              Text(
                '${_filtered.length} products',
                style: GoogleFonts.dmSans(fontSize: 11, color: kMutedFg),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                initialValue: _sortBy,
                onSelected: (val) => setState(() => _sortBy = val),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: kBorder),
                    borderRadius: BorderRadius.circular(50),
                    color: kCard,
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text('Sort',
                        style: GoogleFonts.dmSans(
                            fontSize: 11, color: kForeground)),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down,
                        size: 14, color: kMutedFg),
                  ]),
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'featured',
                    child: Text('Featured',
                        style: GoogleFonts.dmSans(fontSize: 13)),
                  ),
                  PopupMenuItem(
                    value: 'price-asc',
                    child: Text('Price: Low to High',
                        style: GoogleFonts.dmSans(fontSize: 13)),
                  ),
                  PopupMenuItem(
                    value: 'price-desc',
                    child: Text('Price: High to Low',
                        style: GoogleFonts.dmSans(fontSize: 13)),
                  ),
                ],
              ),
            ]),
          ),
        ),

        // ── Product grid ──────────────────────────────────────────────────

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final product = _filtered[i];
                return ProductCard(
                  product: product,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product),
                    ),
                  ),
                );
              },
              childCount: _filtered.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _CategoryTab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: selected ? kPrimary : kSecondary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? kPrimary : kBorder),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 14, color: selected ? Colors.white : kMutedFg),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : kForeground,
            ),
          ),
        ]),
      ),
    );
  }
}
