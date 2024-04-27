import 'package:bora_cozinhar/assets/colors/colors.dart';
import 'package:bora_cozinhar/pages/verduras.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isEnglish = false;

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
                Icons.translate,   // Ícone de tradutor
                color: Paleta.yellow
            ),
            onPressed: () {
              setState(() {
                isEnglish = !isEnglish; // Inverte o valor de isEnglish
              });
            },
          ),
        ],
        backgroundColor: Colors.transparent, // Tornar o AppBar transparente
        elevation: 0, // Remover sombra do AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isEnglish
                  ? 'Feeling like eating\nsomething today?'
                  : 'E aí, tá afim de comer o que hoje?',
              style: GoogleFonts.abel(
                fontSize: 20,
                color: Paleta.yellow
              ), // Estilo do texto
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Paleta.yellow, // Set button color to black
              ),
              child: Text(
                isEnglish
                  ? "Let's go"
                  :'Vamos lá!',
                style: GoogleFonts.abel(
                  fontSize: 20,
                  color: Paleta.black,
                  fontWeight: FontWeight.w600,
                ),
              ), // Texto do botão
            ),
          ],
        ),
      ),
    );
  }
}
