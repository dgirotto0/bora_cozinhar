import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/ingredients_controller.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(
      ChangeNotifierProvider<IngredientsController>(
        create: (context) => IngredientsController(),
        child: BoraCozinhar()),
      );
}

class BoraCozinhar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AICook', // Título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.orange, // Define a cor principal
      ),
      home: WelcomePage(), // Define a WelcomePage como a rota inicial
    );
  }
}
