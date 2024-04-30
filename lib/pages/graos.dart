import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'base/base_page.dart';
import 'carnes.dart';
import '../../constants/language_state.dart';

class GraosPage extends StatelessWidget {
  final List<String> selectedVegetables;
  const GraosPage({super.key, required this.selectedVegetables});

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Wheat',
      'Oats',
      'Rice',
      'Corn',
      'Barley',
      'Millet',
      'Rye',
      'Quinoa',
      'Almonds',
      'Lentils',
      'Beans',
      'Chickpeas',
      'Chia',
      'Sunflower seeds',
    ]
        : const [
      'Trigo',
      'Aveia',
      'Arroz',
      'Milho',
      'Cevada',
      'Painço',
      'Centeio',
      'Quinoa',
      'Amêndoas',
      'Lentilhas',
      'Feijão',
      'Grão-de-bico',
      'Chia',
      'Semente de girassol',
    ];

    return BasePage(
      pageTitle: isEnglish ? 'Grains you have at home?' : 'Quais grãos você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: CarnesPage(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}