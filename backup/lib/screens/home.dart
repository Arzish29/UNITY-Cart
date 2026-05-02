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
import '../services/mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;
  bool _isLoading = true;
  Timer? _festivalTimer;
  Duration _timeToFestival = Duration.zero;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
    _startFestivalCountdown();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _isLoading = false);
  }

  void _startFestivalCountdown() {
    final cp = Provider.of<CommunityProvider>(context, listen: false);
    final festivalDate = DateTime.parse(cp.festivalInfo['date']!);

    _festivalTimer =
        Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      if (festivalDate.isAfter(now)) {
        setState(() => _timeToFestival = festivalDate.difference(now));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _festivalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<CommunityProvider>();
    final cart = context.watch<CartProvider>();
    final isDark = cp.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            /// 🔹 APP BAR
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      "UNITY",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.gold : AppColors.navy,
                      ),
                    ),
                    const Spacer(),

                    /// DARK MODE
                    IconButton(
                      icon: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                      ),
                      onPressed: cp.toggleDarkMode,
                    ),

                    /// SEARCH
                    IconButton(
                      icon: Icon(
                        _showSearch ? Icons.close : Icons.search,
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

                    /// CART
                    badges.Badge(
                      showBadge: cart.itemCount > 0,
                      badgeContent: Text("${cart.itemCount}"),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_bag),
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.cart),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 🔹 SEARCH BAR
            if (_showSearch)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchController,
                    onChanged: cp.setSearch,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

            /// 🔹 GREETING + COMMUNITY (FIXED OVERFLOW)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // ✅ FIX
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
                            ),
                          ),
                          Text(
                            "Discover what’s made for you",
                          ),
                        ],
                      ),
                    ),

                    /// ✅ FIXED WRAP (NO OVERFLOW)
                    Flexible(
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        alignment: WrapAlignment.end,
                        children: cp.selectedCommunities
                            .map((c) => Chip(label: Text(c)))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            /// 🔹 PRODUCTS GRID
            _isLoading
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) =>
                            ProductCard(product: cp.filteredProducts[i]),
                        childCount: cp.filteredProducts.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.68,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}