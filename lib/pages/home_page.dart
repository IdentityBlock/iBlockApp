import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: Image.asset('assets/images/profile.png').image,
                width: 100,
                height: 100,
              ),
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Test User",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Table(
                children: const [
                  TableRow(children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Email Address",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("test@iblock.com"))
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Date of Birth",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: EdgeInsets.all(10), child: Text("01/01/2000"))
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Country",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("United States"))
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Mobile Number",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("+1 123 456 7890"))
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Gender",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.all(10), child: Text("Male"))
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/qrcode-reader');
        },
        child: const Icon(Icons.qr_code),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.light_mode),
            label: 'Theme',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          print(index);
        },
      ),
    );
  }
}
