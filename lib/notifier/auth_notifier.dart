import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthNotifier with ChangeNotifier {
  User? _user;
  User? get user => _user;
  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}
