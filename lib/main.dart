import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/ingredients_controller.dart';
import 'constants/language_state.dart'; // Import LanguageState
import 'pages/welcome_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider( // Use MultiProvider to include multiple providers
      providers: [
        ChangeNotifierProvider<IngredientsController>(
          create: (context) => IngredientsController(),
        ),
        ChangeNotifierProvider<LanguageState>( // Add LanguageState provider
          create: (context) => LanguageState(),
        ),
      ],
      child: BoraCozinhar(),
    ),
  );
}

class BoraCozinhar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AICook',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const WelcomePage(),
    );
  }
}