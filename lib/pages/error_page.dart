import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              width: 40,
              child: Image(image: AssetImage('assets/images/error.png'),),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Encountered An Error!"),
            )
          ],
        ),
      ),
    );
  }

}