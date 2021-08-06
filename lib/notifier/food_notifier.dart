import 'dart:collection';
import 'package:firebasetut1/model/food.dart';
import 'package:flutter/material.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _foodList = [];
  late Food _currentFood;

  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);
  Food get currentFood => _currentFood;

  set foodList(List<Food> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  set currentFood(Food food) {
    _currentFood = food;
    notifyListeners();
  }
}
