// lib/screens/wishlist_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/store_provider.dart';
import '../theme.dart';
import 'product_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, store, _) {
        // ───────────────── EMPTY STATE ─────────────────
        if (store.wishlist.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: kSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 40,
                      color: kMutedFg,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your Wishlist is Empty',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: kForeground,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tap the ♡ on any product to save it here.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: kMutedFg,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // ───────────────── WISHLIST CONTENT ─────────────────
        return CustomScrollView(
          slivers: [
            // ───────── HEADER ─────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kForeground,
                        ),
                        children: const [
                          TextSpan(text: 'My '),
                          TextSpan(
                            text: 'Wishlist',
                            style: TextStyle(
                              color: kPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text(
                              'Clear Wishlist',
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            content: Text(
                              'Remove all items from your wishlist?',
                              style: GoogleFonts.dmSans(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.dmSans(
                                    color: kMutedFg,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final itemsToRemove = store.wishlist.toList();

                                  for (final p in itemsToRemove) {
                                    store.removeFromWishlist(
                                      p.id,
                                    );
                                  }

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Clear All',
                                  style: GoogleFonts.dmSans(
                                    color: const Color(
                                      0xFFDC2626,
                                    ),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Color(0xFFDC2626),
                      ),
                      label: Text(
                        'Clear All',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: const Color(0xFFDC2626),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ───────── PRODUCT LIST ─────────
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                32,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final product = store.wishlist[i];

                    final bool isInCart = store.isInCart(product.id);

                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        color: kCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kBorder),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(
                          12,
                          8,
                          12,
                          8,
                        ),

                        // ───────── NAVIGATE TO DETAILS ─────────
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                product: product,
                              ),
                            ),
                          );
                        },

                        // ───────── PRODUCT IMAGE ─────────
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 64,
                            height: 64,
                            child: Image.network(
                              // FIXED HERE
                              product.image,

                              fit: BoxFit.cover,

                              errorBuilder: (_, __, ___) => Container(
                                color: kSecondary,
                                child: const Icon(
                                  Icons.shopping_bag,
                                  color: kPrimary,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ───────── PRODUCT NAME ─────────
                        title: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kForeground,
                          ),
                        ),

                        // ───────── PRICE ─────────
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text(
                              product.formattedPrice,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: kPrimary,
                              ),
                            ),
                          ],
                        ),

                        // ───────── ACTIONS ─────────
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ───── ADD TO CART ─────
                            GestureDetector(
                              onTap: product.inStock
                                  ? () {
                                      store.addToCart(
                                        product,
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${product.name} added to cart',
                                            style: GoogleFonts.dmSans(),
                                          ),
                                          backgroundColor: kPrimary,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          margin: const EdgeInsets.all(
                                            12,
                                          ),
                                          duration: const Duration(
                                            seconds: 2,
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: !product.inStock
                                      ? kMuted
                                      : isInCart
                                          ? const Color(
                                              0xFF22C55E,
                                            )
                                          : kPrimary,
                                  borderRadius: BorderRadius.circular(
                                    50,
                                  ),
                                ),
                                child: Text(
                                  !product.inStock
                                      ? 'Out of Stock'
                                      : isInCart
                                          ? 'Added'
                                          : 'Add to Cart',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: !product.inStock
                                        ? kMutedFg
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            // ───── REMOVE BUTTON ─────
                            GestureDetector(
                              onTap: () {
                                store.removeFromWishlist(
                                  product.id,
                                );
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFEE2E2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.delete_outline,
                                  size: 16,
                                  color: Color(
                                    0xFFDC2626,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: store.wishlist.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
