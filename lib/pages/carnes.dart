import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'aves.dart';
import 'base/base_page.dart';
import '../../constants/language_state.dart';

class CarnesPage extends StatelessWidget {
  final List<String> selectedVegetables;
  const CarnesPage({super.key, required this.selectedVegetables});

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Rump steak',
      'Picanha',
      'Beef ribs',
      'Filet mignon',
      'Chicken',
      'Sausage',
      'Pork',
      'Lamb',
      'Chicken breast',
      'Dried beef',
      'Ground beef',
      'Zebu hump',
      'Beef brisket',
      'Pork shank',
    ]
        : const [
      'Bife de alcatra',
      'Picanha',
      'Costela bovina',
      'Filé mignon',
      'Frango',
      'Linguiça',
      'Carne de porco',
      'Cordeiro',
      'Peito de frango',
      'Carne seca',
      'Carne moída',
      'Cupim',
      'Maminha',
      'Pernil suíno',
    ];

    return BasePage(
      pageTitle: isEnglish ? 'Meats you have at home?' : 'Quais carnes você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: AvesPage(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}