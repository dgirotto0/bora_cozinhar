import 'package:flutter/material.dart';
import '../assets/colors/colors.dart';
import '../assets/models/receita_model.dart';
import 'api_image.dart';

class ReceitaCard extends StatefulWidget {
  final Receita receita;

  const ReceitaCard({super.key, required this.receita});

  @override
  State<ReceitaCard> createState() => _ReceitaCardState();
}

class _ReceitaCardState extends State<ReceitaCard> {
  bool _showFullDescription = false;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchImage(); // Fetch the image once in initState
  }

  Future<void> _fetchImage() async {
    if (_imageUrl == null) {
      final imageUrl = await fetchRecipeImage(widget.receita.nome);
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  List<TextSpan> _highlightKeywords(String text, List<String> keywords) {
    final List<TextSpan> spans = [];
    int start = 0;

    // Itera sobre as palavras-chave
    for (final keyword in keywords) {
      // Encontra todas as ocorrências da palavra-chave
      final matches = RegExp(keyword).allMatches(text);
      for (final match in matches) {
        // Adiciona o texto antes da palavra-chave
        if (match.start > start) {
          spans.add(TextSpan(text: text.substring(start, match.start)));
        }
        // Adiciona a palavra-chave com destaque
        spans.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: Paleta.laranjaPredominante, // Cor para destacar as palavras
            fontWeight: FontWeight.bold,
          ),
        ));
        start = match.end;
      }
    }
    // Adiciona o texto restante após a última palavra-chave
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(
          color: Paleta.laranjaSuave,
          width: 2
        )
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: Paleta.laranjaSuave,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              widget.receita.nome.replaceAll('**', '').replaceAll('Ingredientes:', 'Receita surpresa'),
              style: const TextStyle(
                fontFamily: 'Abel',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Paleta.laranjaPredominante,
              ),
            ),
            const SizedBox(height: 10),
            _showFullDescription
                ? Column(
              children: [

                const Text(
                  'Modo de Preparo:',
                  style: TextStyle(
                    fontFamily: 'Abel',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Paleta.laranjaPredominante,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    for (final ingrediente in widget.receita.ingredientes)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Tempo de Preparo: ",
                              style: TextStyle(
                                fontFamily: 'Abel',
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            TextSpan(
                              text: ingrediente.nome.replaceAll('**', '').replaceAll('Tempo de Preparo:', '').replaceAll('Tempo de preparo:', ''),
                              style: const TextStyle(
                                fontFamily: 'Abel',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Paleta.laranjaPredominante,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),

                RichText(
                  text: TextSpan(
                    children: _highlightKeywords(
                      widget.receita.descricao.replaceAll('**', '').replaceAll('*', '•'),
                      ['Ingredientes:', 'Instruções:', 'Dicas:'],
                    ),
                    style: TextStyle(
                      fontFamily: 'Abel',
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
                : const SizedBox(),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _showFullDescription = !_showFullDescription),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Paleta.laranjaPredominante,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    _showFullDescription ? 'Ver Menos' : 'Ver Mais',
                    style: const TextStyle(
                      fontFamily: 'Abel',
                      fontSize: 16,
                      color: Paleta.laranjaSuave,
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
