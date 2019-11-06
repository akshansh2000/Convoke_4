import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseHandler {
  FirebaseHandler({
    @required this.emailId,
    @required this.mealType,
    @required this.counter,
  });

  final String emailId;
  final String mealType;
  String counter;

  final databaseReference = FirebaseDatabase.instance.reference();
  SharedPreferences prefs;

  initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> checkDatabase() async {
    await initial();
    if (int.parse(counter) < prefs.getInt("counter"))
      counter = prefs.getInt("counter").toString();

    databaseReference.child(counter).set({
      "emailId": emailId,
      "meal type": mealType,
    });
    return true;
  }

  Future<int> getLastCounterValue() async {
    int value;
    await databaseReference.once().then((DataSnapshot snap) {
      value = snap.value.length;
    });

    return value;
  }
}
