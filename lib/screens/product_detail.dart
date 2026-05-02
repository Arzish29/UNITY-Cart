import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/community_provider.dart';
import '../utils/app_theme.dart';
import '../utils/app_routes.dart';
import 'package:badges/badges.dart' as badges;

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;
  late AnimationController _addToCartController;
  late Animation<double> _cartBounce;

  @override
  void initState() {
    super.initState();
    _addToCartController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _cartBounce = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _addToCartController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _addToCartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final cp = context.watch<CommunityProvider>();
    final cart = context.read<CartProvider>();
    final isDark = cp.isDarkMode;
    final bg = isDark ? AppColors.darkBackground : AppColors.background;
    final surface = isDark ? AppColors.darkSurface : AppColors.surface;
    final textColor = isDark ? Colors.white : AppColors.textDark;

    _selectedSize ??= product.sizes.isNotEmpty ? product.sizes.first : null;
    _selectedColor ??= product.colors.isNotEmpty ? product.colors.first : null;

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Image gallery
              SliverToBoxAdapter(
                child: Hero(
                  tag: 'product_${product.id}',
                  child: Container(
                    height: 380,
                    color: isDark
                        ? const Color(0xFF1a2535)
                        : const Color(0xFFF0EDE8),
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (i) =>
                              setState(() => _currentPage = i),
                          itemCount: product.images.length,
                          itemBuilder: (_, i) => Image.network(
                            product.images[i],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Center(
                              child: Text(
                                _communityEmoji(product.community),
                                style: const TextStyle(fontSize: 80),
                              ),
                            ),
                          ),
                        ),
                        // Back button
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 8,
                          left: 12,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: surface.withOpacity(0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Icon(Icons.arrow_back_ios_new,
                                  size: 16,
                                  color:
                                      isDark ? Colors.white : AppColors.navy),
                            ),
                          ),
                        ),
                        // Cart icon top right
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 8,
                          right: 12,
                          child: badges.Badge(
                            showBadge:
                                context.watch<CartProvider>().itemCount > 0,
                            badgeContent: Text(
                              '${context.watch<CartProvider>().itemCount}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 9),
                            ),
                            badgeStyle: const badges.BadgeStyle(
                              badgeColor: AppColors.gold,
                              padding: EdgeInsets.all(5),
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, AppRoutes.cart),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: surface.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.shopping_bag_outlined,
                                    size: 18,
                                    color:
                                        isDark ? Colors.white : AppColors.navy),
                              ),
                            ),
                          ),
                        ),
                        // Wishlist
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: GestureDetector(
                            onTap: () => cp.toggleWishlist(product.id),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: surface,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Icon(
                                cp.isWishlisted(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: cp.isWishlisted(product.id)
                                    ? Colors.red
                                    : AppColors.textLight,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        // Page indicator
                        if (product.images.length > 1)
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: product.images.length,
                                effect: const WormEffect(
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  activeDotColor: AppColors.gold,
                                  dotColor: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // Product info
              SliverToBoxAdapter(
                child: Container(
                  color: surface,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Community + verified badge row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product.community,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.gold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          if (product.isVerified) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.verified,
                                      color: AppColors.success, size: 13),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Verified Seller',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          if (product.hasTryOn) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.navy.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '✨ Try On',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Name
                      Text(
                        product.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Seller
                      Text(
                        'by ${product.sellerName}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isDark
                              ? Colors.white.withOpacity(0.5)
                              : AppColors.textMedium,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Try On / Actions
                      if (product.hasTryOn)
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _showTryOn(context, product),
                              icon: const Icon(Icons.camera_alt_outlined,
                                  size: 16),
                              label: Text('Try On',
                                  style: GoogleFonts.inter(fontSize: 14)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.navy,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: () {},
                              child: Text('Share',
                                  style: GoogleFonts.inter(fontSize: 13)),
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                      // Rating
                      Row(
                        children: [
                          ...List.generate(5, (i) {
                            return Icon(
                              i < product.rating.floor()
                                  ? Icons.star_rounded
                                  : i < product.rating
                                      ? Icons.star_half_rounded
                                      : Icons.star_outline_rounded,
                              color: AppColors.gold,
                              size: 18,
                            );
                          }),
                          const SizedBox(width: 6),
                          Text(
                            '${product.rating} (${product.reviewCount} reviews)',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: isDark
                                  ? Colors.white.withOpacity(0.6)
                                  : AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${product.price.toInt()}',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.gold : AppColors.navy,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (product.originalPrice > product.price) ...[
                            Text(
                              '₹${product.originalPrice.toInt()}',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: AppColors.textLight,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${product.discountPercent.toInt()}% OFF',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Free delivery on orders above ₹999',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              // Size selector
              if (product.sizes.isNotEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    color: surface,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Size',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: product.sizes.map((size) {
                            final isSelected = _selectedSize == size;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedSize = size),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.navy
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.navy
                                        : isDark
                                            ? const Color(0xFF2A3A4A)
                                            : const Color(0xFFDDDDDD),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  size,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isSelected ? Colors.white : textColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              // Color selector
              if (product.colors.isNotEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    color: surface,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Color',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: product.colors.map((hex) {
                            final color = Color(int.parse(
                                'FF${hex.replaceAll('#', '')}',
                                radix: 16));
                            final isSelected = _selectedColor == hex;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedColor = hex),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(right: 12),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.gold
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check,
                                        size: 16, color: Colors.white)
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              // Quantity + description
              SliverToBoxAdapter(
                child: Container(
                  color: surface,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          Row(
                            children: [
                              _QuantityButton(
                                icon: Icons.remove,
                                onTap: () {
                                  if (_quantity > 1) {
                                    setState(() => _quantity--);
                                  }
                                },
                                isDark: isDark,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '$_quantity',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              _QuantityButton(
                                icon: Icons.add,
                                onTap: () => setState(() => _quantity++),
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          height: 1.6,
                          color: isDark
                              ? Colors.white.withOpacity(0.7)
                              : AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom padding for buttons
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          // Bottom action buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
              decoration: BoxDecoration(
                color: surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Add to Cart
                  Expanded(
                    child: ScaleTransition(
                      scale: _cartBounce,
                      child: ElevatedButton(
                        onPressed: () {
                          _addToCartController
                              .forward()
                              .then((_) => _addToCartController.reverse());
                          cart.addItem(
                            product,
                            size: _selectedSize ?? '',
                            color: _selectedColor ?? '',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to cart',
                                  style: GoogleFonts.inter()),
                              backgroundColor: AppColors.success,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (product.hasTryOn) ...[
                    const SizedBox(width: 12),
                    // Try Virtually
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.camera,
                            arguments: product,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: AppColors.navy,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          '✨ Try Virtually',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTryOn(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background sample model (placeholder)
              Image.network(
                'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.25),
                colorBlendMode: BlendMode.darken,
              ),
              // Product overlay
              Center(
                child: Opacity(
                  opacity: 0.95,
                  child: Image.network(
                    product.images.first,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.6,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
              ),
              // Close button
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _communityEmoji(String community) {
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
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? const Color(0xFF2A3A4A) : const Color(0xFFDDDDDD),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isDark ? Colors.white : AppColors.navy,
        ),
      ),
    );
  }
}
