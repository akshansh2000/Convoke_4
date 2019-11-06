import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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

  Future<bool> checkDatabase() async {
    counter = (await getLastCounterValue()).toString();

    for (int i = 0; i <= int.parse(counter); i++) {
      String tempEmailId, tempMealType;

      await databaseReference
          .child(i.toString() + "/emailId")
          .once()
          .then((DataSnapshot snap) {
        tempEmailId = snap.value;
      });

      await databaseReference
          .child(i.toString() + "/meal type")
          .once()
          .then((DataSnapshot snap) {
        tempMealType = snap.value;
      });

      if (emailId == tempEmailId && mealType == tempMealType) return true;
    }

    return false;
  }

  Future<int> getLastCounterValue() async {
    int value;
    await databaseReference.once().then((DataSnapshot snap) {
      if (snap.value != null)
        value = snap.value.length;
      else
        value = 0;
    });

    return value;
  }

  setDetails() async {
    databaseReference.child(counter).set({
      "emailId": emailId,
      "meal type": mealType,
    });
  }
}
