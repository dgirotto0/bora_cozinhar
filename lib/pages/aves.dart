import 'package:AICook/pages/peixes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'base/base_page.dart';
import '../../constants/language_state.dart'; // Import LanguageState

class AvesPage extends StatelessWidget {
  final List<String> selectedVegetables;
  const AvesPage({Key? key, required this.selectedVegetables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Chicken',
      'Chicken breast',
      'Duck',
      'Turkey',
      'Hen',
      'Quail',
      'Muscovy duck',
      'Pheasant',
      'Pigeon',
      'Goose',
      'Guineafowl',
      'Wild duck',
      'Free-range chicken',
      "Helmeted guineafowl",
    ]
        : const [
      'Frango',
      'Peito de frango',
      'Pato',
      'Peru',
      'Galinha',
      'Codorna',
      'Marreco',
      'Faisão',
      'Pombo',
      'Ganso',
      'Pintada',
      'Pato selvagem',
      'Frango caipira',
      "Galinha d'angola",
    ];

    return BasePage(
      pageTitle: isEnglish ? 'Poultry you have at home?' : 'Quais aves você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: PeixesPage(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}