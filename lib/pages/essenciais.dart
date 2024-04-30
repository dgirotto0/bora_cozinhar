import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'base/base_page.dart';
import 'laticíneos.dart';
import '../../constants/language_state.dart';

class EssenciaisPage extends StatelessWidget {
  const EssenciaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context); // Access LanguageState
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Salt',
      'Sugar',
      'Olive oil',
      'Vinegar',
      'Garlic',
      'Onion',
      'Black pepper',
      'Butter',
      'Eggs',
      'Wheat flour',
      'Milk',
      'Chicken broth',
      'Basil',
    ]
        : const [
      'Sal',
      'Açúcar',
      'Azeite de oliva',
      'Vinagre',
      'Alho',
      'Cebola',
      'Pimenta-do-reino',
      'Manteiga',
      'Ovos',
      'Farinha de trigo',
      'Leite',
      'Caldo de galinha',
      'Manjericão',
    ];

    return BasePage(
      pageTitle: isEnglish
          ? 'Essential ingredients you have at home?'
          : 'Quais ingredientes essenciais você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: LaticineosPage(
          selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}