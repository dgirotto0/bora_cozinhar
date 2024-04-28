import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../assets/colors/colors.dart';
import '../assets/models/receita_model.dart';

class ReceitaCard extends StatefulWidget {
  final Receita receita;

  const ReceitaCard({Key? key, required this.receita}) : super(key: key);

  @override
  State<ReceitaCard> createState() => _ReceitaCardState();
}

class _ReceitaCardState extends State<ReceitaCard> {
  bool _showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da Receita
            Text(
              widget.receita.nome.replaceAll('**', ''),
              style: const TextStyle(
                fontFamily: 'Abel',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Paleta.yellow,
              ),
            ),

            const SizedBox(height: 20),

            // Show remaining content only when 'Ver Mais' is clicked
            _showFullDescription
                ? Column(
              children: [
                // Seção de Ingredientes
                const Text(
                  'Instruções:',
                  style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Paleta.yellow,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    for (final ingrediente in widget.receita.ingredientes)
                      Text(
                        ingrediente.nome.replaceAll('**', ''),
                        style: const TextStyle(
                          fontFamily: 'Abel',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),

                // Descrição da Receita
                Text(
                  widget.receita.descricao.replaceAll('**', ''),
                  style: const TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
                : const SizedBox(),

            // Botão para Mostrar/Esconder Descrição Completa
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _showFullDescription = !_showFullDescription),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Paleta.yellow,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    _showFullDescription ? 'Ver Menos' : 'Ver Mais',
                    style: const TextStyle(
                      fontFamily: 'Abel',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
