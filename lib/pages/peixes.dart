import 'package:AICook/pages/verduras.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'base/base_page.dart';
import '../../constants/language_state.dart';

class PeixesPage extends StatelessWidget {
  final List<String> selectedVegetables;

  const PeixesPage({Key? key, required this.selectedVegetables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    final isEnglish = languageState.isEnglish;

    final ingredientNames = isEnglish
        ? const [
      'Salmon',
      'Tilapia',
      'Cod',
      'Tuna',
      'Sea bass',
      'Grouper',
      'Gilthead sea bream',
      'Painted fish',
      'Tainha',
      'Sole',
      'Sardine',
      'Trout',
      'Piranha',
      'Lambari',
    ]
        : const [
      'Salmão',
      'Tilápia',
      'Bacalhau',
      'Atum',
      'Pescada',
      'Robalo',
      'Dourado',
      'Pintado',
      'Tainha',
      'Linguado',
      'Sardinha',
      'Truta',
      'Piranha',
      'Lambari',
    ];

    return BasePage(
      pageTitle: isEnglish
          ? 'What fish do you have at home?'
          : 'Quais peixes você tem em casa?',
      ingredientNames: ingredientNames,
      nextPage: VerdurasPage(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables),
    );
  }
}