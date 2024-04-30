import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'base/base_page.dart';
import 'graos.dart';
import '../../constants/language_state.dart';

class FrutasPage extends StatelessWidget {
  final List<String> selectedVegetables;
  const FrutasPage({super.key, required this.selectedVegetables});

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Watermelon',
      'Pear',
      'Peach',
      'Mango',
      'Kiwi',
      'Lemon',
      'Cherry',
      'Apple',
      'Banana',
      'Orange',
      'Strawberry',
      'Grape',
      'Pineapple',
      'Melon',
    ]
        : const [
      'Melancia',
      'Pera',
      'Pêssego',
      'Manga',
      'Kiwi',
      'Limão',
      'Cereja',
      'Maçã',
      'Banana',
      'Laranja',
      'Morango',
      'Uva',
      'Abacaxi',
      'Melão',
    ];

    return BasePage(
      pageTitle: isEnglish ? 'Fruits you have at home?' : 'Quais frutas você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: GraosPage(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}