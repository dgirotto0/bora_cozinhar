import 'package:flutter/foundation.dart';

class IngredientsController extends ChangeNotifier {
  List<String> selectedVegetables = [];

  void updateSelectedVegetables(List<String> newVegetables) {
    selectedVegetables = newVegetables;
    notifyListeners(); // Notify listeners of the change
  }
}