import 'package:flutter/material.dart';

// ingredients_controller.dart

class IngredientsController extends ChangeNotifier {
  List<String> _selectedVegetables = []; // Use a private variable to store the data

  List<String> get selectedVegetables => _selectedVegetables; // Getter to access the data

  void updateSelectedVegetables(List<String> newVegetables) {
    _selectedVegetables = newVegetables;
    notifyListeners(); // Notify listeners of the change
  }
}
