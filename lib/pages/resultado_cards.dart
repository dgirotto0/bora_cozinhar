import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../assets/colors/colors.dart';
import '../assets/models/receita_model.dart';
import '../constants/receita_card.dart';

class ReceitasResultadosPage extends StatelessWidget {
  final List<Receita> receitas;


  const ReceitasResultadosPage({super.key, required this.receitas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Paleta.laranjaSuave,
      appBar: AppBar(
        backgroundColor: Paleta.laranjaSuave,
        title: Text(
          'AICook',
          style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Paleta.laranjaPredominante,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
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