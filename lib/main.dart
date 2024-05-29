import 'package:flutter/material.dart';
import 'core/ui_helper.dart';
import 'ui/screens/about_us_screen.dart';
import 'ui/screens/guide_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/menu_screen.dart';
import 'ui/screens/quiz_screen.dart';
import 'ui/screens/result_screen.dart';
import 'ui/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light().copyWith(
          primary: lightblue,
          secondary: lightbrown,
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash-screen': (context) => SplashScreen(),
        '/home-screen': (context) => const HomeScreen(),
        '/menu-screen': (context) => MenuScreen(),
        '/guide-screen': (context) => const GuideScreen(),
        '/quiz-screen': (context) => QuizScreen(),
        '/result-screen': (context) => ResultScreen(),
        '/aboutus-screen': (context) => const AboutUsScreen(),
      },
    );
  }
}
