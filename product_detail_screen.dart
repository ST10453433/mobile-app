// lib/screens/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../theme.dart';
import '../models/product.dart';
import '../providers/store_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, store, _) {
        final inCart = store.isInCart(product.id);
        final inWishlist = store.isInWishlist(product.id);

        return Scaffold(
          backgroundColor: kBackground,

          // ───────────────── APP BAR ─────────────────
          appBar: AppBar(
            backgroundColor: kBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kForeground,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: kForeground,
                ),
                onPressed: () {
                  Share.share(
                    'Check out ${product.name} on Purseonality — ${product.formattedPrice}\n'
                    'https://purseonality.vercel.app',
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  inWishlist ? Icons.favorite : Icons.favorite_border,
                  color: inWishlist ? kPrimary : kForeground,
                ),
                onPressed: () {
                  store.toggleWishlist(product);
                },
              ),
              const SizedBox(width: 4),
            ],
          ),

          // ───────────────── BODY ─────────────────
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ───────── PRODUCT IMAGE ─────────
                SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // FIXED IMAGE PROPERTY HERE
                      Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return Container(
                            color: kSecondary,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: kPrimary,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: product.category == 'weaves'
                                    ? [
                                        const Color(0xFFF8BBD9),
                                        kAccent.withOpacity(0.5),
                                      ]
                                    : [
                                        const Color(0xFFFCE4EC),
                                        kPrimary.withOpacity(0.25),
                                      ],
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                product.category == 'weaves'
                                    ? Icons.content_cut
                                    : Icons.shopping_bag,
                                size: 80,
                                color: kPrimary.withOpacity(0.35),
                              ),
                            ),
                          );
                        },
                      ),

                      // ───────── FEATURED BADGE ─────────
                      if (product.featured)
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: kPrimary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Featured',
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryFg,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ───────────────── DETAILS SECTION ─────────────────
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CATEGORY CHIP
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: kSecondary,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: kBorder),
                        ),
                        child: Text(
                          product.category == 'weaves'
                              ? 'Hair Weaves'
                              : 'Handbags',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: kSecondaryFg,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // PRODUCT NAME
                      Text(
                        product.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kForeground,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // PRICE
                      Text(
                        product.formattedPrice,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: kPrimary,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // DESCRIPTION
                      Text(
                        product.description,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: kMutedFg,
                          height: 1.65,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Divider(color: kBorder),

                      const SizedBox(height: 14),

                      // PRODUCT DETAILS TITLE
                      Text(
                        'Product Details',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: kForeground,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // PRODUCT DETAILS LIST
                      ...product.details.map(
                        (detail) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: kPrimary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  detail,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: kMutedFg,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Divider(color: kBorder),

                      const SizedBox(height: 14),

                      // ───────── STOCK STATUS ─────────
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: product.inStock
                                  ? const Color(0xFF22C55E)
                                  : const Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            product.inStock ? 'In Stock' : 'Out of Stock',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: product.inStock
                                  ? const Color(0xFF22C55E)
                                  : const Color(0xFFEF4444),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ───────── SHIPPING BOX ─────────
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: kSecondary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: kBorder),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_shipping_outlined,
                              size: 18,
                              color: kPrimary,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Free shipping on all orders across South Africa',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  color: kMutedFg,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ───────────────── BOTTOM BAR ─────────────────
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              28,
            ),
            decoration: const BoxDecoration(
              color: kCard,
              border: Border(
                top: BorderSide(color: kBorder),
              ),
            ),
            child: Row(
              children: [
                // ───────── WISHLIST BUTTON ─────────
                GestureDetector(
                  onTap: () {
                    store.toggleWishlist(product);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: inWishlist ? kPrimary : kCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: inWishlist ? kPrimary : kBorder,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      inWishlist ? Icons.favorite : Icons.favorite_border,
                      color: inWishlist ? kPrimaryFg : kPrimary,
                      size: 22,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // ───────── ADD TO CART BUTTON ─────────
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: product.inStock
                          ? () {
                              store.addToCart(product);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} added to cart',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: inCart
                                      ? const Color(0xFF22C55E)
                                      : kPrimary,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  margin: const EdgeInsets.all(12),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !product.inStock
                            ? kMuted
                            : inCart
                                ? const Color(0xFF22C55E)
                                : kPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            inCart ? Icons.check : Icons.shopping_bag_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            !product.inStock
                                ? 'Out of Stock'
                                : inCart
                                    ? 'Added to Bag'
                                    : 'Add to Bag',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
