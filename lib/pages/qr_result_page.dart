import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRResultPage extends StatelessWidget {
  final Barcode result;
  const QRResultPage(this.result, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Result'),
      ),
      body: Center(
        child: Text(result.code != null ? 'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}': 'No result'),
      ),
    );
  }
}
