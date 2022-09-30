import 'package:flutter/material.dart';

import '../widgets/add_new_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                )
              ],
            ),
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
                  builder: (context) => AddNewDialog(addNewProperty)
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

  void addNewProperty(String property, String value){
    setState(() {
      data[property] = value;
    });
  }
}
