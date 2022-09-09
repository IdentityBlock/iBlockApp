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
            children:const [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                child: Image(
                  image: AssetImage('assets/images/welcome2.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Your Data Secured in a \n Blockchain',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
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
              TextButton(onPressed: (){}, child: const Text("NEXT >", style: TextStyle(fontSize: 20),)),
            ],
          ),
        )
    );
  }
}
