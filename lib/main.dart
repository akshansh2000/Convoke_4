import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

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

class _ConvokeAppState extends State<ConvokeApp> {
  String qrCodeResult;
  int tabNumber;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          title: Text("Convoke 4.0"),
          backgroundColor: Colors.black,
          bottom: TabBar(
            isScrollable: true,
            onTap: (index) => tabNumber = index,
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
                  onPressed: () => setState(() async {
                    qrCodeResult = await QRCodeReader().scan();
                  }),
                ),
              ),
            ),
            qrCodeResult == null
                ? Container()
                : Align(
                    alignment: Alignment(0, 0.9),
                    child: Text(
                      qrCodeResult,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
