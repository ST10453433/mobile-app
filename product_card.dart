// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/store_provider.dart';
import '../theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, store, _) {
        final inWishlist = store.isInWishlist(product.id);
        final inCart = store.isInCart(product.id);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE — fills all space above the 52px info strip
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return Container(color: kSecondary);
                            },
                            errorBuilder: (_, __, ___) => Container(
                              color: kSecondary,
                              child: Center(
                                child: Icon(
                                  product.category == 'weaves'
                                      ? Icons.content_cut
                                      : Icons.shopping_bag_outlined,
                                  size: 22,
                                  color: kPrimary.withOpacity(0.4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Wishlist heart
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => store.toggleWishlist(product),
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              inWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 12,
                              color: inWishlist ? kPrimary : kMutedFg,
                            ),
                          ),
                        ),
                      ),
                      // Sold out
                      if (!product.inStock)
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Container(
                              color: Colors.black.withOpacity(0.4),
                              alignment: Alignment.center,
                              child: Text(
                                'Sold Out',
                                style: GoogleFonts.dmSans(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // INFO STRIP — fixed 52px
                SizedBox(
                  height: 52,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: kForeground,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.formattedPrice,
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: kPrimary,
                              ),
                            ),
                            GestureDetector(
                              onTap: product.inStock
                                  ? () {
                                      store.addToCart(product);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Added to cart',
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 12)),
                                          backgroundColor: kPrimary,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: const EdgeInsets.all(12),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  : null,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: !product.inStock
                                      ? kMuted
                                      : inCart
                                          ? const Color(0xFF22C55E)
                                          : kPrimary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  inCart ? Icons.check : Icons.add,
                                  size: 12,
                                  color: !product.inStock
                                      ? kMutedFg
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
