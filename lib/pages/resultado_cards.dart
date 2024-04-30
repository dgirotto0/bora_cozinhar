import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../assets/models/receita_model.dart';
import '../constants/receita_card.dart';

class ReceitasResultadosPage extends StatelessWidget {
  final List<Receita> receitas;


  const ReceitasResultadosPage({super.key, required this.receitas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'AICook',
          style: GoogleFonts.montserrat(fontSize: 20, color: Colors.yellow),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: receitas.length,
                    itemBuilder: (context, index) {
                      return ReceitaCard(receita: receitas[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}