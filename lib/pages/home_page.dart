import 'package:flutter/material.dart';

import '../widgets/add_new_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final data = {"Name": "Test User",
    "Email Address": "test@iblock.com",
    "Date of Birth" : "01/01/2000",
    "Country" : "United States",
    "Mobile Number" : "+1 123 456 7890",
    "Gender" : "Male"
  };

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
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    data["Name"]!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Table(
                children:
                  data.entries.map((e) => TableRow(children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(e.key,
                                style: const TextStyle(fontWeight: FontWeight.bold))),
                        Padding(
                            padding: const EdgeInsets.all(10), child: Text(e.value))
                      ])).toList()
                // const [
                //   TableRow(children: [
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("Email Address",
                //             style: TextStyle(fontWeight: FontWeight.bold))),
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("test@iblock.com"))
                //   ]),
                //   TableRow(children: [
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("Date of Birth",
                //             style: TextStyle(fontWeight: FontWeight.bold))),
                //     Padding(
                //         padding: EdgeInsets.all(10), child: Text("01/01/2000"))
                //   ]),
                //   TableRow(children: [
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("Country",
                //             style: TextStyle(fontWeight: FontWeight.bold))),
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("United States"))
                //   ]),
                //   TableRow(children: [
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("Mobile Number",
                //             style: TextStyle(fontWeight: FontWeight.bold))),
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("+1 123 456 7890"))
                //   ]),
                //   TableRow(children: [
                //     Padding(
                //         padding: EdgeInsets.all(10),
                //         child: Text("Gender",
                //             style: TextStyle(fontWeight: FontWeight.bold))),
                //     Padding(padding: EdgeInsets.all(10), child: Text("Male"))
                //   ]),
                // ],
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
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/history');
              break;
            case 1:
              showDialog(
                  context: context,
                  builder: (context) => const AddNewDialog()
              );
              break;
            case 2:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }
}
