import 'package:flutter/material.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Image.asset('assets/images/icon.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('iBlock', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 40,
            ),
            const CircularProgressIndicator(color: Colors.greenAccent,),
            const SizedBox(
              height: 20,
            ),
            const Text('Loading...'),
          ],
        ),
      ),
    );
  }
}