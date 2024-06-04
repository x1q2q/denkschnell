import 'package:flutter/material.dart';
import 'core/ui_helper.dart';
import 'ui/screens/about_us_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/menu_screen.dart';
import 'ui/screens/quiz2_screen.dart';
import 'ui/screens/quiz1_screen.dart';
import 'ui/screens/quiz3_screen.dart';
import 'ui/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/helpers/question_provider.dart';
import '../../providers/helpers/audio_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => QuestionProvider()),
      ChangeNotifierProvider(create: (_) => AudioProvider())
    ],
    child: const MainApp(),
  ));
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
        '/home-screen': (context) => HomeScreen(),
        '/menu-screen': (context) => MenuScreen(),
        '/quiz1-screen': (context) => Quiz1Screen(),
        '/quiz2-screen': (context) => Quiz2Screen(),
        '/quiz3-screen': (context) => Quiz3Screen(),
        '/aboutus-screen': (context) => AboutUsScreen(),
      },
    );
  }
}
