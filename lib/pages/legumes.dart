import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/checkbox.dart';
import 'frutas.dart';

class Legumes extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Legumes> {
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
              'Quais legumes você tem em casa?',
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
                        buildCheckbox('Abóbora'),
                        buildCheckbox('Batata Doce'),
                        buildCheckbox('Quiabo'),
                        buildCheckbox('Chuchu'),
                        buildCheckbox('Beterraba'),
                        buildCheckbox('Nabo'),
                        buildCheckbox('Cenoura'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        buildCheckbox('Rabanete'),
                        buildCheckbox('Aipo'),
                        buildCheckbox('Aspargo'),
                        buildCheckbox('Milho'),
                        buildCheckbox('Pepino'),
                        buildCheckbox('Vagem'),
                        buildCheckbox('Alho'),
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
                  MaterialPageRoute(builder: (context) => Frutas()),
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
