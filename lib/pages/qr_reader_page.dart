import 'package:flutter/material.dart';

import '../widgets/qr_scanner.dart';

class QrReaderPage extends StatelessWidget {
  const QrReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Reader'),
      ),
      body: const QRScanner()
    );
  }
}
