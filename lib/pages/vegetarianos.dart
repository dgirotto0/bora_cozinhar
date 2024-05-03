import 'package:AICook/pages/receitas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../assets/colors/colors.dart';
import '../constants/ingredients_controller.dart';
import '../../constants/language_state.dart'; // Import LanguageState

class VegPage extends StatefulWidget {
  const VegPage({super.key, required List<String> selectedVegetables});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VegPage> {
  late LanguageState languageState; // Initialize in initState
  final ingredientsController = IngredientsController();

  String _currentTitle = 'Quais vegs você tem em casa?';
  List<String> _currentIngredientNames = [
    'Tofu',
    'Leite de amêndoas',
    'Leite de aveia',
    'Leite de coco',
    'Tempeh',
    'Seitan',
    'Grão-de-bico',
    'Lentilhas',
    'Nozes',
    'Sementes de Chia',
    'Sementes de Linhaça',
    'Coco',
    'Abacate',
    'Espinafre',
  ];

  @override
  void initState() {
    super.initState();
    languageState = Provider.of<LanguageState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = languageState.isEnglish;

    return ChangeNotifierProvider(
      create: (context) => ingredientsController,
      child: Scaffold(
        backgroundColor: Paleta.fundoBranco,
        appBar: AppBar(
          title: Text(
            isEnglish ? "AICook" : 'AICook',
            style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Paleta.laranjaPredominante,
              fontWeight: FontWeight.w500
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.translate,
                color: Paleta.laranjaPredominante,
              ),
              onPressed: () async {
                languageState.toggleLanguage();
                if (isEnglish) {
                  // Translate to English
                  setState(() {
                    _currentTitle = 'What vegs do you have at home?';
                    _currentIngredientNames = [
                      'Tofu',
                      'Almond milk',
                      'Oat milk',
                      'Coconut milk',
                      'Tempeh',
                      'Seitan',
                      'Chickpeas',
                      'Lentils',
                      'Nuts',
                      'Chia seeds',
                      'Flax seeds',
                      'Coconut',
                      'Avocado',
                      'Spinach',
                    ];
                  });
                } else {
                  // Translate back to Portuguese
                  setState(() {
                    _currentTitle = 'Quais vegs você tem em casa?';
                    _currentIngredientNames = [
                      'Tofu',
                      'Leite de amêndoas',
                      'Leite de aveia',
                      'Leite de coco',
                      'Tempeh',
                      'Seitan',
                      'Grão-de-bico',
                      'Lentilhas',
                      'Nozes',
                      'Sementes de Chia',
                      'Sementes de Linhaça',
                      'Coco',
                      'Abacate',
                      'Espinafre',
                    ];
                  });
                }
              },
            ),
          ],
          backgroundColor: Paleta.laranjaSuave,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentTitle,
                    style: GoogleFonts.abel(
                        fontSize: 28,
                        color: Paleta.laranjaPredominante,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ...buildIngredientCheckboxList(),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      final selectedIngredientsString = ingredientsController
                          .selectedVegetables
                          .join(', ');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceitasPage(
                            selectedIngredients: List<String>.from(
                                selectedIngredientsString.split(', ')),
                            initialIngredients: selectedIngredientsString,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Paleta.laranjaPredominante,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      'Next',
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          color: Paleta.textoBranco,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildIngredientCheckboxList() {
    return _currentIngredientNames.map((ingredientName) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Paleta.laranjaSuave,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CheckboxListTile(
            title: Text(
              ingredientName,
              style: GoogleFonts.abel(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
              ),
            ),
            value: ingredientsController.selectedVegetables.contains(ingredientName),
            onChanged: (newValue) {
              setState(() {
                List<String> newVegetables = List.from(ingredientsController.selectedVegetables);
                if (newValue!) {
                  newVegetables.add(ingredientName);
                } else {
                  newVegetables.remove(ingredientName);
                }
                ingredientsController.updateSelectedVegetables(newVegetables);
              });
            },
            activeColor: Paleta.laranjaPredominante,
            checkColor: Paleta.textoBranco,
            controlAffinity: ListTileControlAffinity.platform,
          ),
        ),
      );
    }).toList();
  }
}