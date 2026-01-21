import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/health_data_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Check for first run and initialize data
    final isFirstRun = await StorageService.isFirstRun();
    if (isFirstRun) {
      await StorageService.setFirstRunComplete();
      await StorageService.setAppVersion('1.0.0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HealthDataProvider()..loadData(),
      child: MaterialApp(
        title: 'HealthCheck',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00A99D),
            primary: const Color(0xFF00A99D),
            secondary: const Color(0xFF00695C),
            surface: const Color(0xFFF5F5F5),
            error: const Color(0xFFE53935),
            onPrimary: const Color(0xFFFFFFFF),
            onSecondary: const Color(0xFFFFFFFF),
            onSurface: const Color(0xFF333333),
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              fontFamily: 'Poppins',
            ),
            displayMedium: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              fontFamily: 'Poppins',
            ),
            headlineLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
              fontFamily: 'Poppins',
            ),
            headlineMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
              fontFamily: 'Poppins',
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Color(0xFF333333),
              fontFamily: 'Poppins',
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
              fontFamily: 'Poppins',
            ),
            labelLarge: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
              fontFamily: 'Poppins',
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF00A99D),
            foregroundColor: Color(0xFFFFFFFF),
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
              fontFamily: 'Poppins',
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color(0xFFFFFFFF),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A99D),
              foregroundColor: const Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
              elevation: 2,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF00A99D),
            size: 24,
          ),
          dividerColor: const Color(0xFFE0E0E0),
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}