import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/checkbox.dart';
import 'frutas.dart';
import 'graos.dart';

class Laticineos extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Laticineos> {
  bool isEnglish = false;
  List<String> selectedVegetables = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Paleta.black,
      appBar: AppBar(
        title: Text(isEnglish
            ? 'AICook'
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
              'Quais laticíneos você tem em casa?',
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
                        buildCheckbox('Leite'),
                        buildCheckbox('Queijo'),
                        buildCheckbox('Iogurte'),
                        buildCheckbox('Manteiga'),
                        buildCheckbox('Creme de Leite'),
                        buildCheckbox('Requeijão'),
                        buildCheckbox('Coalhada'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        buildCheckbox('Sorvete'),
                        buildCheckbox('Leite Condensado'),
                        buildCheckbox('Leite em Pó'),
                        buildCheckbox('Iogurte Grego'),
                        buildCheckbox('Queijo Cottage'),
                        buildCheckbox('Queijo Parmesão'),
                        buildCheckbox('Nata'),
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
                  MaterialPageRoute(builder: (context) => Graos()),
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
        isChecked: selectedVegetables.contains(vegetableName),
        onChanged: (newValue) {
          setState(() {
            if (newValue) {
              selectedVegetables.add(vegetableName);
            } else {
              selectedVegetables.remove(vegetableName);
            }
          });
        },
      ),
    );
  }
}
