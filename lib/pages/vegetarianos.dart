import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:bora_cozinhar/pages/receitas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/checkbox.dart';

class Veg extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Veg> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceitasPage()),
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
