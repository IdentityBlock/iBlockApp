import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final AssetImage image;
  final String message;

  const ErrorPage(
      {Key? key,
      this.image = const AssetImage('assets/images/error.png'),
      this.message = "Encountered as Error"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: Image(image: image),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
            TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/");
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.replay_rounded),
                      Text(
                        "Reload",
                        style: TextStyle(fontSize: 16),
                      )
                    ]))
          ],
        ),
      ),
    );
  }
}
