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
            children:const [
              SizedBox(
                height: 100,
              ),
              Text(
                'Single Sign-on for \n Multiple Platforms',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Image(
                  image: AssetImage('assets/images/welcome3.png'),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          )
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){}, child: const Text("< BACK", style: TextStyle(fontSize: 20),)),
              TextButton(onPressed: (){}, child: const Text("DONE", style: TextStyle(fontSize: 20),)),
            ],
          ),
        )
    );
  }
}