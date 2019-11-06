import 'package:flutter/material.dart';

class FirebaseHandler extends StatefulWidget {
  FirebaseHandler({Key key, @required this.textResult, @required this.mealType}) : super(key: key);
  final String textResult;
  final String mealType;

  _FirebaseHandlerState createState() => _FirebaseHandlerState();
}

class _FirebaseHandlerState extends State<FirebaseHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          widget.textResult,
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
