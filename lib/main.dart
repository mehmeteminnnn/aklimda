import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/game_setup_screen.dart';
import 'providers/game_provider.dart';
import 'providers/language_provider.dart';
import 'utils/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/tutorial_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  MobileAds.instance.initialize().then((initializationStatus) {
    debugPrint(
        'MobileAds initialization status: ${initializationStatus.adapterStatuses}');
  });

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

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
        home: isFirstTime ? const TutorialScreen() : const SplashScreen(),
        routes: {
          '/setup': (context) => const GameSetupScreen(),
        },
      ),
    );
  }
}
