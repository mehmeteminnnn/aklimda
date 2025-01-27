import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/game_setup_screen.dart';
import 'providers/game_provider.dart';
import 'providers/language_provider.dart';
import 'utils/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize().then((initializationStatus) {
    debugPrint(
        'MobileAds initialization status: ${initializationStatus.adapterStatuses}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aklımda',
        theme: AppTheme.lightTheme,
        navigatorKey: navigatorKey,
        home: const SplashScreen(),
        routes: {
          '/setup': (context) => const GameSetupScreen(),
        },
      ),
    );
  }
}
