import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../assets/colors/colors.dart';
import '../assets/models/receita_model.dart';
import '../constants/receita_card.dart';

class ReceitasResultadosPage extends StatelessWidget {
  final List<Receita> receitas;


  const ReceitasResultadosPage({Key? key, required this.receitas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Paleta.black,
      appBar: AppBar(
        title: Text(
          'AICook',
          style: GoogleFonts.abel(
            fontSize: 22,
            color: Paleta.yellow,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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