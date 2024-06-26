import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../assets/colors/colors.dart';
import 'essenciais.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isEnglish = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Paleta.fundoBranco,
      appBar: AppBar(
        title: Text(
          isEnglish ? "AICook" : 'AICook',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            color: Paleta.laranjaPredominante,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.translate,
              color: Paleta.laranjaPredominante,
            ),
            onPressed: () {
              setState(() {
                isEnglish = !isEnglish;
              });
            },
          ),
        ],
        backgroundColor: Paleta.laranjaSuave,
        elevation: 0,
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
                fontSize: 24,
                color: Paleta.laranjaPredominante,
                fontWeight: FontWeight.w700
              ), // Estilo do texto
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EssenciaisPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Paleta.laranjaPredominante, // Set button color to black
              ),
              child: Text(
                isEnglish ? "Let's go" : 'Vamos lá!',
                style: GoogleFonts.abel(
                  fontSize: 20,
                  color: Paleta.textoBranco,
                  fontWeight: FontWeight.w600,
                ),
              ), // Texto do botão
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Paleta.laranjaSuave,
        child: Container(
          height: 40,
          child: Center(
            child: Text(
              isEnglish ? 'Developed by Daniel Girotto' : 'Desenvolvido por Daniel Girotto',
              style: GoogleFonts.abel(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Paleta.laranjaPredominante,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
