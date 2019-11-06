import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convoke_4/firebase_handler.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() => runApp(
      MaterialApp(
        home: ConvokeApp(),
        debugShowCheckedModeBanner: false,
      ),
    );

class ConvokeApp extends StatefulWidget {
  @override
  _ConvokeAppState createState() => _ConvokeAppState();
}

class _ConvokeAppState extends State<ConvokeApp>
    with SingleTickerProviderStateMixin {
  String qrCodeResult;
  int tabNumber;
  static int counter;
  TabController customTabController;
  List<String> mealTypes = ["Evening Snacks", "Dinner", "Breakfast", "Lunch"];
  SharedPreferences sharedPreferences;

  counterInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("counter"))
      counter = sharedPreferences.getInt("counter");
    else {
      counter = 0;
      sharedPreferences.setInt("counter", 0);
    }
  }

  @override
  void initState() {
    super.initState();
    customTabController = TabController(vsync: this, length: 4);
    counterInit();
  }

  @override
  void dispose() {
    customTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: Text("Convoke 4.0"),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: customTabController,
          isScrollable: true,
          onTap: (index) {
            setState(() {
              tabNumber = index;
            });
          },
          indicatorColor: Colors.redAccent[700],
          labelStyle: TextStyle(fontWeight: FontWeight.w900),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
          tabs: <Widget>[
            Tab(text: "Evening Snacks"),
            Tab(text: "Dinner"),
            Tab(text: "Breakfast"),
            Tab(text: "Lunch"),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: <Widget>[
          TabBarView(
            controller: customTabController,
            children: <Widget>[
              Container(),
              Container(),
              Container(),
              Container(),
            ],
          ),
          Center(
            child: Container(
              width: 150,
              height: 150,
              child: FloatingActionButton(
                child: Icon(
                  Icons.add_a_photo,
                  size: 70,
                ),
                onPressed: () => setState(
                  () async {
                    qrCodeResult = await QRCodeReader().scan();
                    qrCodeResult == null
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: Center(
                                  child: Text(
                                    "QR Scan Failed",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : checkDatabase();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkDatabase() async {
    FirebaseHandler firebaseHandler = FirebaseHandler(
      emailId: qrCodeResult,
      mealType: mealTypes[customTabController.index],
      counter: counter.toString(),
    );

    counter = await firebaseHandler.getLastCounterValue();
    sharedPreferences.setInt("counter", counter);

    bool didAddValue = await firebaseHandler.checkDatabase();

    if (didAddValue) {
      counter++;
      sharedPreferences.setInt("counter", counter);
    }
  }
}
