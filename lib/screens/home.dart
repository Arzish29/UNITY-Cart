import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '../providers/community_provider.dart';
import '../providers/cart_provider.dart';
import '../utils/app_theme.dart';
import '../utils/app_routes.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/coupon_card.dart';
import '../services/mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;
  bool _isLoading = true;
  Timer? _festivalTimer;
  Duration _timeToFestival = Duration.zero;
  late AnimationController _headerController;
  late Animation<double> _headerFade;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _headerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );
    _simulateLoading();
    _startFestivalCountdown();
    _headerController.forward();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _isLoading = false);
  }

  void _startFestivalCountdown() {
    final communityProv =
        Provider.of<CommunityProvider>(context, listen: false);
    final info = communityProv.festivalInfo;
    final festivalDate = DateTime.parse(info['date']!);
    _updateCountdown(festivalDate);
    _festivalTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown(festivalDate);
    });
  }

  void _updateCountdown(DateTime festivalDate) {
    final now = DateTime.now();
    if (festivalDate.isAfter(now)) {
      setState(() => _timeToFestival = festivalDate.difference(now));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _festivalTimer?.cancel();
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<CommunityProvider>();
    final cart = context.watch<CartProvider>();
    final isDark = cp.isDarkMode;
    final bg = isDark ? AppColors.darkBackground : AppColors.background;
    final surface = isDark ? AppColors.darkSurface : AppColors.surface;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverToBoxAdapter(
              child: Container(
                color: surface,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Logo
                    Text(
                      'UNITY',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.gold : AppColors.navy,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'CART',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Dark mode toggle
                    IconButton(
                      icon: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode_outlined,
                        color: isDark ? AppColors.gold : AppColors.navy,
                        size: 22,
                      ),
                      onPressed: () => cp.toggleDarkMode(),
                    ),
                    // Search
                    IconButton(
                      icon: Icon(
                        _showSearch ? Icons.close : Icons.search,
                        color: isDark ? Colors.white : AppColors.navy,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          _showSearch = !_showSearch;
                          if (!_showSearch) {
                            _searchController.clear();
                            cp.setSearch('');
                          }
                        });
                      },
                    ),
                    // Cart
                    badges.Badge(
                      showBadge: cart.itemCount > 0,
                      badgeContent: Text(
                        '${cart.itemCount}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 9),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: AppColors.gold,
                        padding: EdgeInsets.all(5),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: isDark ? Colors.white : AppColors.navy,
                          size: 22,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.cart),
                      ),
                    ),
                    // Profile
                    GestureDetector(
                      onTap: () => _showProfileSheet(context, cp, isDark),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.navy,
                          border: Border.all(
                              color: AppColors.gold.withOpacity(0.5),
                              width: 1.5),
                        ),
                        child: const Icon(Icons.person_outline,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Search bar
            if (_showSearch)
              SliverToBoxAdapter(
                child: Container(
                  color: surface,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: cp.setSearch,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      filled: true,
                      fillColor:
                          isDark ? AppColors.darkCard : AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
            // Greeting + festival card
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _headerFade,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cp.greeting,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isDark ? Colors.white : AppColors.navy,
                                  ),
                                ),
                                Text(
                                  'Discover what\'s made for you',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: isDark
                                        ? Colors.white.withOpacity(0.5)
                                        : AppColors.textMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Community chips
                          Wrap(
                            spacing: 4,
                            children: cp.selectedCommunities.map((c) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.gold.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.gold.withOpacity(0.4),
                                  ),
                                ),
                                child: Text(
                                  c,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: isDark
                                        ? AppColors.gold
                                        : AppColors.navy,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Festival card
                      _FestivalCountdownCard(
                        info: cp.festivalInfo,
                        timeLeft: _timeToFestival,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Coupon section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      '🎉 Special Offers For You',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.navy,
                      ),
                    ),
                  ),
                  ...MockData.getRandomCoupons(cp.primaryCommunity, count: 2)
                      .map((coupon) => CouponCard(
                            coupon: coupon,
                            isDark: isDark,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Code ${coupon.code} copied!',
                                    style: GoogleFonts.inter(),
                                  ),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            // Categories
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Text(
                      'Categories',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.navy,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cp.categories.length,
                      itemBuilder: (_, i) {
                        final cat = cp.categories[i];
                        return CategoryChip(
                          label: cat,
                          isSelected: cp.activeFilter == cat,
                          onTap: () => cp.setFilter(cat),
                          isDark: isDark,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Products header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _searchQuery(cp).isNotEmpty
                          ? 'Search Results'
                          : 'For You',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.navy,
                      ),
                    ),
                    Text(
                      '${cp.filteredProducts.length} items',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark
                            ? Colors.white.withOpacity(0.5)
                            : AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Products grid
            _isLoading
                ? SliverToBoxAdapter(
                    child: _SkeletonGrid(isDark: isDark),
                  )
                : cp.filteredProducts.isEmpty
                    ? SliverToBoxAdapter(
                        child: _EmptyState(isDark: isDark),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (_, i) =>
                                ProductCard(product: cp.filteredProducts[i]),
                            childCount: cp.filteredProducts.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.68,
                          ),
                        ),
                      ),
            // Recently viewed
            if (!_isLoading && cp.recentlyViewed.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Text(
                    'Recently Viewed',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.navy,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cp.recentlyViewed.length,
                    itemBuilder: (_, i) {
                      final p = cp.recentlyViewed[i];
                      return GestureDetector(
                        onTap: () {
                          cp.addRecentlyViewed(p.id);
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetail,
                            arguments: p,
                          );
                        },
                        child: Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color:
                                isDark ? AppColors.darkCard : AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: isDark
                                        ? const Color(0xFF1a2535)
                                        : const Color(0xFFF0EDE8),
                                    child: Image.network(
                                      p.images.first,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Center(
                                        child: Text(
                                          _communityEmoji(p.community),
                                          style: const TextStyle(fontSize: 28),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? Colors.white
                                              : AppColors.textDark,
                                        ),
                                      ),
                                      Text(
                                        '₹${p.price.toInt()}',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.gold,
                                        ),
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
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ],
        ),
      ),
    );
  }

  String _searchQuery(CommunityProvider cp) => cp.searchQuery;

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

  void _showProfileSheet(
      BuildContext context, CommunityProvider cp, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Profile',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.navy,
              ),
            ),
            const SizedBox(height: 16),
            // Language toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
                Row(
                  children: ['en', 'ar'].map((lang) {
                    return GestureDetector(
                      onTap: () => cp.setLanguage(lang),
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: cp.language == lang
                              ? AppColors.navy
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.navy),
                        ),
                        child: Text(
                          lang == 'en' ? 'English' : 'عربي',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: cp.language == lang
                                ? Colors.white
                                : AppColors.navy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            // Change community
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.communitySelect);
              },
              child: Row(
                children: [
                  const Icon(Icons.group_outlined,
                      color: AppColors.navy, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Change Community',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FestivalCountdownCard extends StatelessWidget {
  final Map<String, String> info;
  final Duration timeLeft;
  final bool isDark;

  const _FestivalCountdownCard({
    required this.info,
    required this.timeLeft,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final days = timeLeft.inDays;
    final hours = timeLeft.inHours % 24;
    final mins = timeLeft.inMinutes % 60;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0D1B2A),
            Color(0xFF1A3A5C),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            info['emoji']!,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${info['name']} is coming!',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Shop your festival essentials',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.gold.withOpacity(0.4), width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      '$days',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.gold,
                      ),
                    ),
                    Text(
                      'days',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonGrid extends StatelessWidget {
  final bool isDark;
  const _SkeletonGrid({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (_, __) => _SkeletonCard(isDark: isDark),
      ),
    );
  }
}

class _SkeletonCard extends StatefulWidget {
  final bool isDark;
  const _SkeletonCard({required this.isDark});

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmer;
  late Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _shimmerAnim = Tween<double>(begin: 0.5, end: 1.0).animate(_shimmer);
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnim,
      builder: (_, __) => Opacity(
        opacity: _shimmerAnim.value,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkCard : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? const Color(0xFF1e2d3d)
                        : const Color(0xFFE8E4DF),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? const Color(0xFF1e2d3d)
                              : const Color(0xFFE8E4DF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      Container(
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? const Color(0xFF1e2d3d)
                              : const Color(0xFFE8E4DF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        height: 14,
                        width: 60,
                        decoration: BoxDecoration(
                          color: widget.isDark
                              ? const Color(0xFF1e2d3d)
                              : const Color(0xFFE8E4DF),
                          borderRadius: BorderRadius.circular(7),
                        ),
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

class _EmptyState extends StatelessWidget {
  final bool isDark;
  const _EmptyState({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            const Text('🔍', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.navy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search or category',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: isDark
                    ? Colors.white.withOpacity(0.5)
                    : AppColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
