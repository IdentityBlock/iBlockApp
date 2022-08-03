import 'package:flutter/material.dart';

import './pages/qr_reader_page.dart';
import './pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: AppBarTheme(
          color: Colors.grey.shade200,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primarySwatch: Colors.blue,
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
          default:
            builder = (context) => const HomePage();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      }),
    );
  }
}
