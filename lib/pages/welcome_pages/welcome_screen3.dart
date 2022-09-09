import 'package:flutter/material.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({Key? key}) : super(key: key);

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
                'Single Sign-on for \n Multiple Platforms',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                child: Image(
                  image: AssetImage('assets/images/welcome3.png'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){}, child: const Text("< BACK")),
                  TextButton(onPressed: (){}, child: const Text("NEXT >")),
                ],
              ),
            ],
          )
      ),
    );
  }
}