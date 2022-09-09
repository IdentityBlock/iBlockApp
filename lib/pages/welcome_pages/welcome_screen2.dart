import 'package:flutter/material.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({Key? key}) : super(key: key);

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
              const SizedBox(
                child: Image(
                  image: AssetImage('assets/images/welcome2.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your Data Secured in a \n Blockchain',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
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
