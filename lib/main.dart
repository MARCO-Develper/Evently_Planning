import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/login/login_screen.dart';
import 'package:evently/on_boarding_screen.dart';
import 'package:evently/providers/AuthProvider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/my_provider.dart';
import 'package:evently/screens/create_event.dart';
import 'package:evently/screens/home/home.dart';
import 'package:evently/screens/introduction_screen.dart';
import 'package:evently/screens/register_screen.dart';
import 'package:evently/theme/dark_theme.dart';
import 'package:evently/theme/light_theme.dart';
import 'package:evently/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize Firebase first
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: true,
    );
    print("Firebase initialized successfully");
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  // Set up error handling
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    final authProvider = Provider.of<UserProvider>(context);

    // Initialize user if logged in
    if (authProvider.currentUser != null && authProvider.userModel == null) {
      authProvider.initUser();
    }

    final BaseTheme lightTheme = LightTheme();
    final BaseTheme darkTheme = DarkTheme();

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme.themeData,
      darkTheme: darkTheme.themeData,
      themeMode: provider.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: _getInitialRoute(authProvider),
      routes: _getAppRoutes(),
    );
  }

  String _getInitialRoute(UserProvider authProvider) {
    if (authProvider.currentUser != null) {
      return HomeScreen.routeName;
    }
    return IntroductionScreen.routeName;
  }

  Map<String, WidgetBuilder> _getAppRoutes() {
    return {
      IntroductionScreen.routeName: (context) => const IntroductionScreen(),
      OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
      LoginScreen.routeName: (context) => const LoginScreen(),
      RegisterScreen.routeName: (context) => RegisterScreen(),
      HomeScreen.routeName: (context) => const HomeScreen(),
      CreateEvent.routeName: (context) => CreateEvent(),
    };
  }
}