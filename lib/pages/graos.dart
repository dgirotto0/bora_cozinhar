import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/ingredients_controller.dart';
import 'carnes.dart';
import '../constants/checkbox.dart';

class Graos extends StatefulWidget {
  final List<String> selectedVegetables;

  const Graos({Key? key, required this.selectedVegetables}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Graos> {
  bool isEnglish = false;
  List<String> selectedVegetables = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Paleta.black,
      appBar: AppBar(
        title: Text(isEnglish
            ? "AICook"
            : 'AICook',
          style: GoogleFonts.abel(
              fontSize: 22,
              color: Paleta.yellow
          ),
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
              'Quais grãos você tem em casa?',
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
                        buildCheckbox('Arroz'),
                        buildCheckbox('Feijão'),
                        buildCheckbox('Trigo'),
                        buildCheckbox('Milho'),
                        buildCheckbox('Aveia'),
                        buildCheckbox('Cevada'),
                        buildCheckbox('Quinoa'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        buildCheckbox('Lentilha'),
                        buildCheckbox('Grão-de-bico'),
                        buildCheckbox('Ervilha'),
                        buildCheckbox('Fava'),
                        buildCheckbox('Amendoim'),
                        buildCheckbox('Soja'),
                        buildCheckbox('Semente de Linhaça'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Carnes(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables)),
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
    );
  }
  Widget buildCheckbox(String vegetableName) {
    return ListTile(
      title: Text(
        vegetableName,
        style: GoogleFonts.abel(
            fontSize: 20,
            color: Paleta.white
        ),
      ),
      leading: RoundedCheckbox(
        isChecked: Provider.of<IngredientsController>(context).selectedVegetables.contains(vegetableName),
        onChanged: (newValue) {
          final ingredientsController = Provider.of<IngredientsController>(context, listen: false);
          final currentVegetables = ingredientsController.selectedVegetables;
          if (newValue) {
            ingredientsController.updateSelectedVegetables(currentVegetables..add(vegetableName));
          } else {
            ingredientsController.updateSelectedVegetables(currentVegetables..remove(vegetableName));
          }
        },
      ),
    );
  }
}
