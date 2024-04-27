import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../assets/colors/colors.dart';
import '../assets/models/receita_model.dart';

class ReceitaCard extends StatelessWidget {
  final Receita receita;

  const ReceitaCard({Key? key, required this.receita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                receita.nome,
                style: GoogleFonts.abel(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Paleta.yellow,
                ),
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  const Icon(Icons.timer, color: Paleta.yellow),
                  const SizedBox(width: 5),
                  Text(
                    '${receita.tempoPreparo} minutos',
                    style: GoogleFonts.abel(
                      fontSize: 16,
                      color: Paleta.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Text(
                'Ingredientes:',
                style: GoogleFonts.abel(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Paleta.yellow,
                ),
              ),
              const SizedBox(height: 10),

              Column(
                children: [
                  for (final ingrediente in receita.ingredientes)
                    Text(
                      '${ingrediente.quantidade} ${ingrediente.nome}',
                      style: GoogleFonts.abel(
                        fontSize: 16,
                        color: Paleta.white,
                      ),
                    ),
                ],
              ),

              SizedBox(
                height: 200,
                child: Image.network(
                  receita.imagemUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15),

              Text(
                receita.descricao,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.abel(
                  fontSize: 16,
                  color: Paleta.white,
                ),
              ),
              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  print('Ver mais detalhes da receita: ${receita.nome}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Paleta.yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Ver Mais',
                  style: GoogleFonts.abel(
                    fontSize: 16,
                    color: Paleta.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
