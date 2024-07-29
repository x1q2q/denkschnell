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
import '../../providers/helpers/backsound_provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(create: (_) => BacksoundProvider())
      ],
      child: const MainApp(),
    ));
  });
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
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash-screen': (context) => const SplashScreen(),
        '/home-screen': (context) => const HomeScreen(),
        '/menu-screen': (context) => const MenuScreen(),
        '/quiz1-screen': (context) => const Quiz1Screen(),
        '/quiz2-screen': (context) => const Quiz2Screen(),
        '/quiz3-screen': (context) => const Quiz3Screen(),
        '/aboutus-screen': (context) => const AboutUsScreen(),
      },
    );
  }
}
