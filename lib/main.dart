import 'package:startup/screens/change_level.dart';
import 'package:startup/screens/change_practice.dart';
import 'package:startup/screens/enter.dart';
import 'package:startup/screens/greetings.dart';
import 'package:startup/screens/home.dart';
import 'package:startup/screens/login.dart';
import 'package:startup/screens/templates/change_theory.dart';
import 'package:startup/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: StaticColors.backgroundColor),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/greetings': (context) => const GreetingsScreen(),
        '/enter': (context) =>
            EnterScreen(onExitTap: () => {SystemNavigator.pop()}),
        '/login': (context) =>
            LoginScreen(onExitTap: () => {SystemNavigator.pop()}),
        '/change_user': (context) =>
            EnterScreen(onExitTap: () => {Navigator.pop(context)}),
        '/home': (context) => const HomeScreen(),
        '/change_level': (context) => const ChangeLevelScreen(),
        '/change_practice': (context) => const ChangePracticeScreen(),
        '/change_theory': (context) => const ChangeTheoryScreen(),
      },
    );
  }
}

