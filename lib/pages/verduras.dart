import 'package:AICook/pages/vegetarianos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'base/base_page.dart';
import '../../constants/language_state.dart';

class VerdurasPage extends StatelessWidget {
  final List<String> selectedVegetables;

  const VerdurasPage({super.key, required this.selectedVegetables});

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Lettuce',
      'Spinach',
      'Arugula',
      'Watercress',
      'Kale',
      'Broccoli',
      'Carrot',
      'Tomato',
      'Cucumber',
      'Zucchini',
      'Bell pepper',
      'Chives',
      'Cilantro',
      'Parsley',
    ]
        : const [
      'Alface',
      'Espinafre',
      'Rúcula',
      'Agrião',
      'Couve',
      'Brócolis',
      'Cenoura',
      'Tomate',
      'Pepino',
      'Abobrinha',
      'Pimentão',
      'Cebolinha',
      'Coentro',
      'Salsinha',
    ];

    return BasePage(
      pageTitle: isEnglish
          ? 'What vegetables do you have at home?'
          : 'Quais verduras você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: VegPage(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}