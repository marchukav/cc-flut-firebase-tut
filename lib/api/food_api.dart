import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetut1/model/food.dart';
import 'package:firebasetut1/model/user.dart';
import 'package:firebasetut1/notifier/auth_notifier.dart';
import 'package:firebasetut1/notifier/food_notifier.dart';

login(IntUser user, AuthNotifier authNotifier) async {
  try {
    UserCredential authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user.email, password: user.password);

    if (authResult != null) {
      User? firebaseUser = authResult.user;

      if (firebaseUser != null) {
        print('Loggin $firebaseUser');
        authNotifier.setUser(firebaseUser);
      }
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  // UserCredential authResult = await FirebaseAuth.instance
  //     .signInWithEmailAndPassword(email: user.email, password: user.password)
  //     .catchError((error) => print(error.hashCode));
}

signUp(IntUser user, AuthNotifier authNotifier) async {
  try {
    UserCredential authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password);
    if (authResult != null) {
      authResult.user!.updateDisplayName(user.displayName);
      print('Sign Up ${authResult.user}');

      User? firebaseUser = await FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        authNotifier.setUser(firebaseUser);
      }
    }
  } catch (e) {
    print(e);
  }
}

signOut(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.hashCode));
  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  User? firebaseUser = await FirebaseAuth.instance.currentUser;

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getFood(FoodNotifier foodNotifier) async {
  try {
    FirebaseFirestore.instance
        .collection('food')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<Food> _foodList = [];
      // snapshot.docs.forEach((document) {
      querySnapshot.docs.forEach((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Food food = Food.fromMap(data);
        _foodList.add(food);
      });
      foodNotifier.foodList = _foodList;
    });
  } catch (e) {
    print(e);
  }

  // QuerySnapshot snapshot =
  //     await FirebaseFirestore.instance.collection('food').get();
  //
  // List<Food> _foodList = [];
  // snapshot.docs.forEach((document) {
  //   Food food = Food.fromMap(document.data() as Map<String, dynamic>);
  //   _foodList.add(food);
  // });
  //
  // foodNotifier.foodList = _foodList;
}
