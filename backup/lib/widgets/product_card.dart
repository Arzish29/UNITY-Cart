import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
      duration: const Duration(milliseconds: 600),
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
    final isWishlisted = community.isWishlisted(widget.product.id);
    final isDark = community.isDarkMode;
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
      child: Hero(
        tag: 'product_${widget.product.id}',
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Image section ──────────────────────────────────────────
              Expanded(
                flex: 5,
                // ClipRRect is OUTSIDE the Stack so it properly
                // constrains the rounded corners
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  // StackFit.expand forces the Stack AND all its
                  // children to match the Expanded size exactly —
                  // this is what eliminates the overflow
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ColoredBox(
                        color: isDark
                            ? const Color(0xFF1a2535)
                            : const Color(0xFFF0EDE8),
                        child: Image.network(
                          widget.product.images.first,
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, progress) {
                            if (progress == null) return child;
                            return _ShimmerBox(isDark: isDark);
                          },
                          errorBuilder: (_, __, ___) => _PlaceholderImage(
                            community: widget.product.community,
                            isDark: isDark,
                          ),
                        ),
                      ),
                      // Wishlist button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () =>
                              community.toggleWishlist(widget.product.id),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: cardBg,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
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
                      // Try-On badge
                      if (widget.product.hasTryOn)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Try On',
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.navy,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      // Discount badge
                      if (widget.product.discountPercent > 0)
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${widget.product.discountPercent.toInt()}% OFF',
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // ── Info section ───────────────────────────────────────────
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                          height: 1.3,
                        ),
                      ),
                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: AppColors.gold, size: 13),
                          const SizedBox(width: 3),
                          Text(
                            '${widget.product.rating}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppColors.gold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${widget.product.reviewCount})',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                      // Price + cart
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${widget.product.price.toInt()}',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isDark
                                      ? AppColors.gold
                                      : AppColors.navy,
                                ),
                              ),
                              if (widget.product.originalPrice >
                                  widget.product.price)
                                Text(
                                  '₹${widget.product.originalPrice.toInt()}',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: AppColors.textLight,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _cartAnim.forward().then((_) {
                                _cartAnim.reverse();
                              });
                              context
                                  .read<CartProvider>()
                                  .addItem(widget.product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Added to cart',
                                    style: GoogleFonts.inter(fontSize: 13),
                                  ),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                            child: AnimatedBuilder(
                              animation: _cartAnim,
                              builder: (_, __) => Transform.scale(
                                scale: 1.0 -
                                    (_cartAnim.value *
                                        0.15 *
                                        (1 - _cartAnim.value) *
                                        4),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: cart.containsProduct(
                                            widget.product.id)
                                        ? AppColors.success
                                        : AppColors.navy,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    cart.containsProduct(widget.product.id)
                                        ? Icons.check
                                        : Icons.add_shopping_cart_outlined,
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
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final bool isDark;
  const _ShimmerBox({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: isDark ? const Color(0xFF1e2d3d) : const Color(0xFFE8E4DF),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  final String community;
  final bool isDark;

  const _PlaceholderImage({required this.community, required this.isDark});

  String get _emoji {
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
    return ColoredBox(
      color: isDark ? const Color(0xFF1a2535) : const Color(0xFFF0EDE8),
      child: Center(
        child: Text(_emoji, style: const TextStyle(fontSize: 36)),
      ),
    );
  }
}