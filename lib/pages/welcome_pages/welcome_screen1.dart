import 'package:flutter/material.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Protect your Identity with ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'iBlock',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(
              child: Image(
                image: AssetImage('assets/images/welcome1.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){}, child: const Text("Skip")),
                TextButton(onPressed: (){}, child: const Text("Next >")),
              ],
            ),
          ],
        )
      ),
    );
  }
}