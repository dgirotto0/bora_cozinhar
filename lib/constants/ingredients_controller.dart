import 'package:flutter/material.dart';

class IngredientsController extends ChangeNotifier {
  final TextEditingController _textController = TextEditingController();

  String get text => _textController.text;

  void updateIngredients(String ingredients) {
    _textController.text = ingredients;
    notifyListeners();
  }
}