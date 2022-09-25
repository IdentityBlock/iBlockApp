import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRResultPage extends StatelessWidget {
  final Barcode result;
  const QRResultPage(this.result, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print((jsonDecode(result.code!) as Map<String, dynamic>)['information']
        as List);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Requesting Information'),
        ),
        body: (result.code == null)
            ? const Center(
                child: Text('Error'),
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 9,
                        child: Column(
                          children: ((jsonDecode(result.code!)
                                      as Map<String, dynamic>)['information']
                                  as List<dynamic>)
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ))
                              .toList(),
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.blue)
                                      .copyWith(
                                          elevation:
                                              ButtonStyleButton.allOrNull(0.0)),
                              child: const Text("Approve"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red)
                                      .copyWith(
                                          elevation:
                                              ButtonStyleButton.allOrNull(0.0)),
                              child: const Text("Decline"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
        // Center(
        //   child: Text(result.code != null ? 'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}': 'No result'),
        // ),
        );
  }
}
