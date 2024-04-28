import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/checkbox.dart';
import '../constants/ingredients_controller.dart';
import 'laticíneos.dart';

class Frutas extends StatefulWidget {

  final List<String> selectedVegetables;

  const Frutas({Key? key, required this.selectedVegetables}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Frutas> {
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
              'Quais frutas você tem em casa?',
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
                        buildCheckbox('Melancia'),
                        buildCheckbox('Pera'),
                        buildCheckbox('Pêssego'),
                        buildCheckbox('Manga'),
                        buildCheckbox('Kiwi'),
                        buildCheckbox('Limão'),
                        buildCheckbox('Cereja'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        buildCheckbox('Maçã'),
                        buildCheckbox('Banana'),
                        buildCheckbox('Laranja'),
                        buildCheckbox('Morango'),
                        buildCheckbox('Uva'),
                        buildCheckbox('Abacaxi'),
                        buildCheckbox('Melão'),
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
                      builder: (context) => Laticineos(selectedVegetables: Provider.of<IngredientsController>(context).selectedVegetables)),
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
