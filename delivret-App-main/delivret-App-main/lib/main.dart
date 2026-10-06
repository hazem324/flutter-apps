import 'package:deliveryapp/utils/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/language_constant.dart';
import 'view/screen/client_home_screen.dart';
import 'view/screen/forget_password_screen.dart';
import 'view/screen/livreur_home_Screen.dart';
import 'view/screen/login_screen.dart';
import 'view/screen/signup_screen.dart';
import 'view/screen/splash_screen.dart';
import 'view/screen/start_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }
}

class MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      locale: _locale,
      //screen
      initialRoute: splashScreen,
      routes: {
        loginScreen: (context) => const LoginScreen(),
        splashScreen: (context) => const SplashScreen(),
        signUpScreen: (context) => const SignUpScreen(),
        startScreen: (context) => const StartScreen(),
        clientHomeScreen: (context) => const ClientHomeScreen(),
        livreurHomeScreen: (context) => LivreurHomeScreen(),
        forgetPasswordScreen: (context) => const ForgetPasswordScreen(),
       // chatConversationScreen: (context) => ChatConversationScreen(),
      },
    );
  }
}
