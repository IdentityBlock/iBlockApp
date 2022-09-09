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
          children:const [
            SizedBox(
              height: 100,
            ),
            Text(
              'Protect your Identity with ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'iBlock',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(
              child: Image(
                image: AssetImage('assets/images/welcome1.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){}, child: const Text("SKIP", style: TextStyle(fontSize: 20),)),
            TextButton(onPressed: (){}, child: const Text("NEXT >", style: TextStyle(fontSize: 20),)),
          ],
        ),
      )
    );
  }
}