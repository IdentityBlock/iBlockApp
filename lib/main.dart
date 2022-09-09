import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import './pages/qr_reader_page.dart';
import './pages/home_page.dart';
import './pages/qr_result_page.dart';
import './pages/signup_page.dart';
import './pages/opening_screen.dart';

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
        )
      ),
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade900,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        )
      ),
      themeMode: ThemeMode.system,

      // routes
      initialRoute: '/',
      onGenerateRoute: ((settings){
        WidgetBuilder builder;
        switch(settings.name){
          case '/':
            builder = (context) => const HomePage();
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
          default:
            builder = (context) => const HomePage();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      }),
    );
  }
}
