import 'package:flutter/material.dart';

import '../widgets/qr_scanner.dart';

class QrReaderPage extends StatelessWidget {
  const QrReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.transparent,
        child: const Icon(Icons.close, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: const QRScanner()
    );
  }
}
