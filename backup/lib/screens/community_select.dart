import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/community_provider.dart';
import '../utils/app_theme.dart';
import '../utils/app_routes.dart';

class CommunitySelectScreen extends StatefulWidget {
  const CommunitySelectScreen({super.key});

  @override
  State<CommunitySelectScreen> createState() => _CommunitySelectScreenState();
}

class _CommunitySelectScreenState extends State<CommunitySelectScreen>
    with TickerProviderStateMixin {
  final List<String> _tempSelected = [];
  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardAnimations;

  final List<Map<String, dynamic>> _communities = [
    {
      'name': 'Muslim',
      'emoji': '🌙',
      'desc': 'Hijabs, Abayas, Halal',
      'gradient': [const Color(0xFF1a4a6e), const Color(0xFF0D1B2A)],
    },
    {
      'name': 'Hindu',
      'emoji': '🪔',
      'desc': 'Sarees, Kurtas, Puja',
      'gradient': [const Color(0xFF7a3500), const Color(0xFF4a2000)],
    },
    {
      'name': 'Christian',
      'emoji': '✝️',
      'desc': 'Church Wear, Pendants',
      'gradient': [const Color(0xFF1a3a6e), const Color(0xFF0a2040)],
    },
    {
      'name': 'Sikh',
      'emoji': '🙏',
      'desc': 'Turban, Kara, Phulkari',
      'gradient': [const Color(0xFF2d5a00), const Color(0xFF1a3a00)],
    },
    {
      'name': 'Buddhist',
      'emoji': '☸️',
      'desc': 'Robes, Mala, Bowls',
      'gradient': [const Color(0xFF7a4a00), const Color(0xFF4a2a00)],
    },
  ];

  @override
  void initState() {
    super.initState();
    _cardControllers = List.generate(
      _communities.length,
      (i) => AnimationController(
        duration: Duration(milliseconds: 400 + i * 80),
        vsync: this,
      ),
    );
    _cardAnimations = _cardControllers.map((c) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: c, curve: Curves.easeOutBack),
      );
    }).toList();
    _staggerCards();
  }

  Future<void> _staggerCards() async {
    for (int i = 0; i < _cardControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (mounted) _cardControllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _cardControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _continue() async {
    if (_tempSelected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one community',
              style: GoogleFonts.inter()),
          backgroundColor: AppColors.navy,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    await context.read<CommunityProvider>().setCommunities(_tempSelected);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.navy, Color(0xFF0a1520)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.gold.withOpacity(0.3), width: 1),
                      ),
                      child: Text(
                        'UMMA MALL',
                        style: GoogleFonts.inter(
                          color: AppColors.gold,
                          fontSize: 11,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Which community\ndo you shop for?',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select one or more. We\'ll personalize everything for you.',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Community grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    itemCount: _communities.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.05,
                    ),
                    itemBuilder: (context, index) {
                      final comm = _communities[index];
                      final isSelected =
                          _tempSelected.contains(comm['name']);
                      return AnimatedBuilder(
                        animation: _cardAnimations[index],
                        builder: (_, __) => Transform.scale(
                          scale: _cardAnimations[index].value,
                          child: _CommunityTile(
                            community: comm,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _tempSelected.remove(comm['name']);
                                } else {
                                  _tempSelected.add(comm['name'] as String);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Continue button
              Padding(
                padding: const EdgeInsets.all(24),
                child: AnimatedOpacity(
                  opacity: _tempSelected.isNotEmpty ? 1 : 0.4,
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 0.3,
                            ),
                          ),
                          if (_tempSelected.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.navy.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${_tempSelected.length} selected',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
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

class _CommunityTile extends StatefulWidget {
  final Map<String, dynamic> community;
  final bool isSelected;
  final VoidCallback onTap;

  const _CommunityTile({
    required this.community,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CommunityTile> createState() => _CommunityTileState();
}

class _CommunityTileState extends State<_CommunityTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradients = widget.community['gradient'] as List<Color>;
    return GestureDetector(
      onTapDown: (_) => _pressController.reverse(),
      onTapUp: (_) {
        _pressController.forward();
        widget.onTap();
      },
      onTapCancel: () => _pressController.forward(),
      child: ScaleTransition(
        scale: _pressController,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradients,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isSelected ? AppColors.gold : Colors.transparent,
              width: 2.5,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 0,
                    )
                  ]
                : [],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.community['emoji'] as String,
                      style: const TextStyle(fontSize: 32),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.community['name'] as String,
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.community['desc'] as String,
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.isSelected)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gold,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.navy,
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
