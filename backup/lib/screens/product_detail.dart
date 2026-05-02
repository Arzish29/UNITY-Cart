import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/community_provider.dart';
import '../utils/app_theme.dart';
import '../utils/app_routes.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartAnim;

  @override
  void initState() {
    super.initState();
    _cartAnim = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _cartAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final community = context.watch<CommunityProvider>();

    final isDark = community.isDarkMode;
    final isWishlisted = community.isWishlisted(widget.product.id);

    final cardBg = isDark ? AppColors.darkCard : AppColors.surface;
    final textColor = isDark ? Colors.white : AppColors.textDark;

    return GestureDetector(
      onTap: () {
        community.addRecentlyViewed(widget.product.id);
        Navigator.pushNamed(
          context,
          AppRoutes.productDetail,
          arguments: widget.product,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 IMAGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.product.images.first,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder: (context, url) => _PlaceholderImage(
                        community: widget.product.community,
                        isDark: isDark,
                        isLoading: true,
                      ),
                      errorWidget: (context, url, error) => _PlaceholderImage(
                        community: widget.product.community,
                        isDark: isDark,
                        isLoading: false,
                      ),
                    ),
                  ),
                ),

                /// Wishlist
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => community.toggleWishlist(widget.product.id),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: cardBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isWishlisted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isWishlisted
                            ? Colors.red
                            : AppColors.textLight,
                        size: 16,
                      ),
                    ),
                  ),
                ),

                /// Discount badge
                if (widget.product.discountPercent > 0)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${widget.product.discountPercent.toInt()}% OFF',
                        style: const TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),

            /// 🔹 DETAILS
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: AppColors.gold, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '${widget.product.rating}',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '(${widget.product.reviewCount})',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppColors.textLight,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${widget.product.price.toInt()}',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.gold
                                      : AppColors.navy,
                                ),
                              ),
                              if (widget.product.originalPrice >
                                  widget.product.price)
                                Text(
                                  '₹${widget.product.originalPrice.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _cartAnim.forward().then((_) {
                              _cartAnim.reverse();
                            });
                            context
                                .read<CartProvider>()
                                .addItem(widget.product);
                          },
                          child: AnimatedBuilder(
                            animation: _cartAnim,
                            builder: (_, __) => Transform.scale(
                              scale: 1 -
                                  (_cartAnim.value *
                                      0.2 *
                                      (1 - _cartAnim.value)),
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: cart.containsProduct(
                                          widget.product.id)
                                      ? AppColors.success
                                      : AppColors.navy,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  cart.containsProduct(widget.product.id)
                                      ? Icons.check
                                      : Icons.add_shopping_cart,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
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
  }
}

/// Placeholder shown while loading or on error
class _PlaceholderImage extends StatelessWidget {
  final String community;
  final bool isDark;
  final bool isLoading;

  const _PlaceholderImage({
    required this.community,
    required this.isDark,
    required this.isLoading,
  });

  String get emoji {
    switch (community) {
      case 'Muslim':
        return '🌙';
      case 'Hindu':
        return '🪔';
      case 'Sikh':
        return '🙏';
      case 'Christian':
        return '✝️';
      case 'Buddhist':
        return '☸️';
      default:
        return '🛍️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? const Color(0xFF1a2535) : const Color(0xFFF0EDE8),
      child: Center(
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDark ? AppColors.gold : AppColors.navy,
                ),
              )
            : Text(emoji, style: const TextStyle(fontSize: 32)),
      ),
    );
  }
}