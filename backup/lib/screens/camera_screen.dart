import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/community_provider.dart';
import '../utils/app_theme.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  File? _capturedImage;
  bool _showResult = false;
  late AnimationController _overlayController;
  late Animation<double> _overlayOpacity;
  late Animation<double> _overlayScale;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _overlayController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _overlayOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeIn),
    );
    _overlayScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _overlayController.dispose();
    super.dispose();
  }

  Future<void> _captureFromCamera() async {
    setState(() => _isCapturing = true);
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (photo != null && mounted) {
        setState(() {
          _capturedImage = File(photo.path);
          _showResult = true;
          _isCapturing = false;
        });
        _overlayController.forward();
      } else {
        setState(() => _isCapturing = false);
      }
    } catch (e) {
      setState(() => _isCapturing = false);
      if (mounted) {
        _showPermissionDialog();
      }
    }
  }

  Future<void> _pickFromGallery() async {
    setState(() => _isCapturing = true);
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (photo != null && mounted) {
        setState(() {
          _capturedImage = File(photo.path);
          _showResult = true;
          _isCapturing = false;
        });
        _overlayController.forward();
      } else {
        setState(() => _isCapturing = false);
      }
    } catch (e) {
      setState(() => _isCapturing = false);
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Camera Access', style: GoogleFonts.playfairDisplay()),
        content: Text(
          'Please allow camera access in your device settings to use the Try-On feature.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: GoogleFonts.inter(color: AppColors.navy)),
          ),
        ],
      ),
    );
  }

  void _reset() {
    setState(() {
      _capturedImage = null;
      _showResult = false;
    });
    _overlayController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final product =
        ModalRoute.of(context)!.settings.arguments as Product;
    final cp = context.watch<CommunityProvider>();
    final cart = context.read<CartProvider>();
    final isDark = cp.isDarkMode;

    return Scaffold(
      backgroundColor: Colors.black,
      body: _showResult && _capturedImage != null
          ? _buildResultView(product, cart, isDark)
          : _buildCaptureView(product, isDark),
    );
  }

  Widget _buildCaptureView(Product product, bool isDark) {
    return Stack(
      children: [
        // Background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF050A10), Color(0xFF0D1B2A)],
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 20),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Virtual Try-On',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              // Product preview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.gold.withOpacity(0.3), width: 1),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Image.network(
                            product.images.first,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFF1a2535),
                              child: Center(
                                child: Text(
                                  _emoji(product.community),
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${product.price.toInt()}',
                              style: GoogleFonts.inter(
                                color: AppColors.gold,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '✨ Try On',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Camera viewfinder frame
              Center(
                child: Container(
                  width: 260,
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.gold.withOpacity(0.5), width: 2),
                  ),
                  child: Stack(
                    children: [
                      // Corner decorations
                      ...['tl', 'tr', 'bl', 'br'].map((pos) =>
                          _Corner(position: pos)),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.white.withOpacity(0.3),
                              size: 60,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Position yourself\nin the frame',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Instruction text
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Stand straight • Good lighting • Full body visible',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              // Capture buttons
              Padding(
                padding: EdgeInsets.fromLTRB(
                    24, 0, 24, MediaQuery.of(context).padding.bottom + 24),
                child: Column(
                  children: [
                    // Camera button
                    GestureDetector(
                      onTap: _isCapturing ? null : _captureFromCamera,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isCapturing
                              ? Colors.grey
                              : Colors.white,
                          border: Border.all(
                            color: AppColors.gold,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gold.withOpacity(0.3),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: _isCapturing
                            ? const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.navy,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.camera_alt_rounded,
                                color: AppColors.navy,
                                size: 28,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Gallery option
                    TextButton.icon(
                      onPressed: _isCapturing ? null : _pickFromGallery,
                      icon: const Icon(Icons.photo_library_outlined,
                          color: AppColors.gold, size: 18),
                      label: Text(
                        'Pick from gallery',
                        style: GoogleFonts.inter(
                          color: AppColors.gold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultView(
      Product product, CartProvider cart, bool isDark) {
    return Stack(
      children: [
        // Captured image
        Positioned.fill(
          child: Image.file(
            _capturedImage!,
            fit: BoxFit.cover,
          ),
        ),
        // Dark overlay
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
        // Product overlay - centered on upper body
        Positioned(
          top: MediaQuery.of(context).size.height * 0.12,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _overlayController,
            builder: (_, __) => FadeTransition(
              opacity: _overlayOpacity,
              child: Transform.scale(
                scale: _overlayScale.value,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.images.first,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              _emoji(product.community),
                              style: const TextStyle(fontSize: 60),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Try-On label
        Positioned(
          top: MediaQuery.of(context).size.height * 0.12 - 30,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: _overlayOpacity,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '✨ Virtual Try-On Preview',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Top close button
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ),
        // Bottom buttons
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(
                20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.85),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product info
                Text(
                  product.name,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${product.price.toInt()}',
                  style: GoogleFonts.inter(
                    color: AppColors.gold,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          cart.addItem(product);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added to cart',
                                  style: GoogleFonts.inter()),
                              backgroundColor: AppColors.success,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _reset,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                              color: Colors.white70, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Try Another',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 14),
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
    );
  }

  String _emoji(String community) {
    switch (community) {
      case 'Muslim': return '🌙';
      case 'Hindu': return '🪔';
      case 'Sikh': return '🙏';
      case 'Christian': return '✝️';
      case 'Buddhist': return '☸️';
      default: return '🛍️';
    }
  }
}

class _Corner extends StatelessWidget {
  final String position;
  const _Corner({required this.position});

  @override
  Widget build(BuildContext context) {
    final top = position.startsWith('t');
    final left = position.endsWith('l');
    return Positioned(
      top: top ? 0 : null,
      bottom: top ? null : 0,
      left: left ? 0 : null,
      right: left ? null : 0,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? const BorderSide(color: AppColors.gold, width: 3)
                : BorderSide.none,
            bottom: !top
                ? const BorderSide(color: AppColors.gold, width: 3)
                : BorderSide.none,
            left: left
                ? const BorderSide(color: AppColors.gold, width: 3)
                : BorderSide.none,
            right: !left
                ? const BorderSide(color: AppColors.gold, width: 3)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
