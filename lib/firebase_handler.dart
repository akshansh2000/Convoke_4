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
  final String counter;

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  bool checkDatabase() {
    databaseReference.child(counter).set({
      "emailId": emailId,
      "meal type": mealType,
    });
    return true;
  }
}
