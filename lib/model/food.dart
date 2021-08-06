import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id = '';
  String name = '';
  String category = '';
  String image = '';
  List? subingridients = [];
  Timestamp createdAt = Timestamp.fromDate(DateTime.now());

  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    subingridients = data['ingridients'];
    createdAt = data['createdAt'];
  }
}
