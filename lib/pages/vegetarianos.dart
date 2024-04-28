import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:bora_cozinhar/pages/receitas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/checkbox.dart';
import '../constants/ingredients_controller.dart';

class Veg extends StatefulWidget {
  final List<String> selectedVegetables;

  const Veg({Key? key, required this.selectedVegetables}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Veg> {
  bool isEnglish = false;
  final ingredientsController = IngredientsController();

  @override
  Widget build(BuildContext context) {
    final ingredientsController =
        Provider.of<IngredientsController>(context); // Access the provider
    return ChangeNotifierProvider(
        create: (context) => ingredientsController, // Provider for IngredientsController
        child:Scaffold(
          backgroundColor: Paleta.black,
          appBar: AppBar(
            title: Text(
              isEnglish ? "AICook" : 'AICook',
              style: GoogleFonts.abel(fontSize: 22, color: Paleta.yellow),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.translate,
                  color: Paleta.yellow,
                ),
                onPressed: () {
                  setState(() {
                    isEnglish = !isEnglish;
                  });
                },
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quais vegs você tem em casa?',
                  style: GoogleFonts.abel(fontSize: 23, color: Paleta.yellow),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            buildCheckbox('Feijão'),
                            buildCheckbox('Grão de Bico'),
                            buildCheckbox('Lentilha'),
                            buildCheckbox('Tofu'),
                            buildCheckbox('Quinoa'),
                            buildCheckbox('Aveia'),
                            buildCheckbox('Arroz Integral'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            buildCheckbox('Amêndoas'),
                            buildCheckbox('Nozes'),
                            buildCheckbox('Sementes de Chia'),
                            buildCheckbox('Sementes de Linhaça'),
                            buildCheckbox('Coco'),
                            buildCheckbox('Abacate'),
                            buildCheckbox('Espinafre'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final selectedIngredientsString =
                    ingredientsController.selectedVegetables.join(', ');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceitasPage(
                          selectedIngredients: List<String>.from(selectedIngredientsString.split(', ')), // Convert string to list
                          initialIngredients: selectedIngredientsString,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Paleta.yellow, // Set button color to black
                  ),
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    color: Paleta.white,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Widget buildCheckbox(String vegetableName) {
    return ListTile(
      title: Text(
        vegetableName,
        style: GoogleFonts.abel(fontSize: 20, color: Paleta.white),
      ),
      leading: RoundedCheckbox(
        isChecked: Provider.of<IngredientsController>(context, listen: false).selectedVegetables.contains(vegetableName),
        onChanged: (newValue) {
          List<String> newVegetables = List.from(Provider.of<IngredientsController>(context, listen: false).selectedVegetables);
          if (newValue) {
            newVegetables.add(vegetableName);
          } else {
            newVegetables.remove(vegetableName);
          }
          Provider.of<IngredientsController>(context, listen: false).updateSelectedVegetables(newVegetables);
        },
      ),
    );
  }
}
