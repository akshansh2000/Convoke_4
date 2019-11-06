import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseHandler {
  FirebaseHandler({@required this.emailId, @required this.mealType});
  final String emailId;
  final String mealType;

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
}
