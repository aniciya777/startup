import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup/screens/achievements.dart';
import 'package:startup/screens/change_level.dart';
import 'package:startup/screens/change_practice.dart';
import 'package:startup/screens/change_theory.dart';
import 'package:startup/screens/enter.dart';
import 'package:startup/screens/greetings.dart';
import 'package:startup/screens/home.dart';
import 'package:startup/screens/initial.dart';
import 'package:startup/screens/login.dart';
import 'package:startup/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:startup/shared/strings.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)) {
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
    };
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        title: StaticStrings.appName,
        debugShowCheckedModeBanner: false,
        builder: FToastBuilder(),
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: StaticColors.backgroundColor),
          useMaterial3: true,
        ),
        initialRoute: '/initial',
        routes: {
          '/initial': (context) => const InitialScreen(),
          '/greetings': (context) => const GreetingsScreen(),
          '/enter': (context) =>
              EnterScreen(onExitTap: () => {SystemNavigator.pop()}),
          '/login': (context) =>
              LoginScreen(onExitTap: () => {SystemNavigator.pop()}),
          '/change_user': (context) =>
              EnterScreen(onExitTap: () => {Navigator.pop(context)}),
          '/achievements': (context) =>
              AchievementsScreen(onExitTap: () => {Navigator.pop(context)}),
          '/home': (context) => const HomeScreen(),
          '/change_level': (context) => const ChangeLevelScreen(),
          '/change_practice': (context) => const ChangePracticeScreen(),
          '/change_theory': (context) => const ChangeTheoryScreen(),
        },
      ),
    );
  }
}
