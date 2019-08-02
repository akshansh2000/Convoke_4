import 'package:flutter/material.dart';

main() => runApp(
      MaterialApp(
        home: ConvokeApp(),
        debugShowCheckedModeBanner: false,
      ),
    );

class ConvokeApp extends StatelessWidget {
  Widget customContainer(BuildContext context, Color color) {
    return Center(
      child: Container(
        width: 400,
        height: 400,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          title: Text("Convoke 4.0"),
          backgroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: Colors.redAccent[700],
            labelStyle: TextStyle(fontWeight: FontWeight.w900),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
            tabs: <Widget>[
              Tab(text: "Lorem"),
              Tab(text: "Ipsum"),
              Tab(text: "Dolor"),
              Tab(text: "Sit"),
              Tab(text: "Amet"),
            ],
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: TabBarView(
          children: <Widget>[
            customContainer(context, Colors.indigo),
            customContainer(context, Colors.blue),
            customContainer(context, Colors.green),
            customContainer(context, Colors.yellow),
            customContainer(context, Colors.teal),
          ],
        ),
      ),
    );
  }
}
