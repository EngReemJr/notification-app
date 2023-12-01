import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';





class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

}