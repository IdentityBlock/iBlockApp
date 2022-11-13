import 'package:flutter/material.dart';

class CoveredLoading extends StatelessWidget {
  const CoveredLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: CircularProgressIndicator()),
        ));
  }
}
