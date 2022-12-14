import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import './pages/home_page.dart';
import './pages/login_history_page.dart';
import './pages/opening_screen.dart';
import './pages/qr_reader_page.dart';
import './pages/qr_result_page.dart';
import './pages/settings_page.dart';
import './pages/signup_page.dart';
import './pages/welcome_pages/welcome_screen1.dart';
import './pages/welcome_pages/welcome_screen2.dart';
import './pages/welcome_pages/welcome_screen3.dart';
import './pages/error_page.dart';
import './pages/enter_address_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OpeningScreen(),
      theme: ThemeData.light().copyWith(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: AppBarTheme(
            color: Colors.grey.shade200,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade200,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )),
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
            color: Colors.grey.shade900,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey.shade900,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          )),
      themeMode: ThemeMode.system,

      // routes
      initialRoute: '/',
      onGenerateRoute: ((settings){
        WidgetBuilder builder;
        switch(settings.name){
          case '/home':
            builder = (context) => HomePage();
            break;
          case '/qrcode-reader':
            builder = (context) => const QrReaderPage();
            break;
          case '/qrcode-result':
            builder = (context) => QRResultPage(settings.arguments as Barcode);
            break;
          case '/signin':
            builder = (context) => const SignUpPage();
            break;
          case '/welcome1':
            builder = (context) => const WelcomeScreen1();
            break;
          case '/welcome2':
            builder = (context) => const WelcomeScreen2();
            break;
          case '/welcome3':
            builder = (context) => const WelcomeScreen3();
            break;
          case '/history':
            builder = (context) => const LoginHistoryPage();
            break;
          case '/settings':
            builder = (context) => const SettingsPage();
            break;
          case '/signup':
            builder = (context) => const SignUpPage();
            break;
          case '/enter-address':
            builder = (context) => const EnterAddressPage();
            break;
          case '/error':
            builder = (context) => const ErrorPage();
            final arguments = settings.arguments as Map<String, Object>;
            if (arguments.containsKey('message')){
              builder = (context) => ErrorPage(message: arguments['message'] as String);
            }
            break;
          default:
            builder = (context) => HomePage();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      }),
    );
  }
}
