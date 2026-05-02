import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/community_provider.dart';
import 'providers/cart_provider.dart';
import 'utils/app_theme.dart';
import 'utils/app_routes.dart';
import 'screens/splash.dart';
import 'screens/community_select.dart';
import 'screens/home.dart';
import 'screens/product_detail.dart';
import 'screens/camera_screen.dart';
import 'screens/cart.dart';
import 'screens/order_success.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommunityProvider()..init()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const UnityCartApp(),
    ),
  );
}

class UnityCartApp extends StatelessWidget {
  const UnityCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<CommunityProvider>().isDarkMode;

    return MaterialApp(
      title: 'Unity Cart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.communitySelect: (_) => const CommunitySelectScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.productDetail: (_) => const ProductDetailScreen(),
        AppRoutes.camera: (_) => const CameraScreen(),
        AppRoutes.cart: (_) => const CartScreen(),
        AppRoutes.orderSuccess: (_) => const OrderSuccessScreen(),
      },
    );
  }
}
