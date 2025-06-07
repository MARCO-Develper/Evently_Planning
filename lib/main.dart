import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/login/login_screen.dart';
import 'package:evently/on_boarding_screen.dart';
import 'package:evently/providers/AuthProvider.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);

    return true;
  };
  // await FirebaseFirestore.instance.enableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
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
    var provider = Provider.of<MyProvider>(context);
    var authProvider = Provider.of<UserProvider>(context);

    BaseTheme lightTheme = LightTheme();
    BaseTheme darkTheme = DarkTheme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme.themeData,
      darkTheme: darkTheme.themeData,
      themeMode: provider.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: authProvider.currentUser != null
          ? HomeScreen.routeName
          : IntroductionScreen.routeName,
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        IntroductionScreen.routeName: (context) => const IntroductionScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        CreateEvent.routeName: (context) => CreateEvent(),
      },
    );
  }
}
