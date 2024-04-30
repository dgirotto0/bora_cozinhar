import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          isEnglish ? "AICook" : 'AICook',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            color: Colors.yellow,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.translate,
              color: Colors.yellow,
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
              isEnglish
                  ? 'Feeling like eating\nsomething today?'
                  : 'E aí, tá afim de comer o que hoje?',
              style: GoogleFonts.abel(
                fontSize: 20,
                color: Colors.yellow,
              ), // Estilo do texto
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EssenciaisPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Set button color to black
              ),
              child: Text(
                isEnglish ? "Let's go" : 'Vamos lá!',
                style: GoogleFonts.abel(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ), // Texto do botão
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              isEnglish ? 'Developed by Daniel Girotto' : 'Desenvolvido por Daniel Girotto',
              style: GoogleFonts.abel(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.yellow,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
