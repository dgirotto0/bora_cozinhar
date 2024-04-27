import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/checkbox.dart';
import 'legumes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEnglish = false;
  List<String> selectedVegetables = [];
  String selectedIngredients = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Paleta.black,
      appBar: AppBar(
        title: Text(
          'AICook',
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
              'Quais vegetais você tem em casa?',
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
                        buildCheckbox('Alface'),
                        buildCheckbox('Espinafre'),
                        buildCheckbox('Rúcula'),
                        buildCheckbox('Abobrinha'),
                        buildCheckbox('Berinjela'),
                        buildCheckbox('Batata'),
                        buildCheckbox('Ervilha'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        buildCheckbox('Cenoura'),
                        buildCheckbox('Brócolis'),
                        buildCheckbox('Couve'),
                        buildCheckbox('Tomate'),
                        buildCheckbox('Cebola'),
                        buildCheckbox('Pepino'),
                        buildCheckbox('Pimentão'),
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
                  MaterialPageRoute(builder: (context) => Legumes()),

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
          color: Paleta.white,
        ),
      ),
      leading: RoundedCheckbox(
        isChecked: selectedIngredients.contains(vegetableName),
        onChanged: (newValue) {
          setState(() {
            if (newValue) {
              selectedIngredients += "$vegetableName, "; // Add comma for separation
            } else {
              selectedIngredients = selectedIngredients.replaceAll("$vegetableName, ", ""); // Remove vegetable and comma
            }
          });
        },
      ),
    );
  }
}
