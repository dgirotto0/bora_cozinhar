import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'base/base_page.dart';
import 'frutas.dart';
import '../../constants/language_state.dart';

class LaticineosPage extends StatelessWidget {
  final List<String> selectedVegetables;

  const LaticineosPage({Key? key, required this.selectedVegetables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Milk',
      'Cheese',
      'Yogurt',
      'Butter',
      'Eggs',
      'Cream',
      'Cream cheese',
      'Condensed milk',
      'Shredded cheese',
      'Curd',
      'Ricotta',
      'Chocolate',
      'Greek yogurt',
    ]
        : const [
      'Leite',
      'Queijo',
      'Iogurte',
      'Manteiga',
      'Ovos',
      'Creme de leite',
      'Requeijão',
      'Leite condensado',
      'Queijo ralado',
      'Coalhada',
      'Ricota',
      'Cream cheese',
      'Chocolate',
      'Iogurte grego',
    ];

    return BasePage(
      pageTitle: isEnglish
          ? 'What dairy products and eggs do you have at home?'
          : 'Quais laticínios e ovos você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: FrutasPage(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}