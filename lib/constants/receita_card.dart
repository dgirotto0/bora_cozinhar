import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    final imageUrl = await fetchRecipeImage(widget.receita.nome);
    setState(() {
      _imageUrl = imageUrl;
    });
  }

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

            Text(
              widget.receita.nome.replaceAll('**', ''),
              style: const TextStyle(
                fontFamily: 'Abel',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<String?>(
              future: fetchRecipeImage(widget.receita.nome),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final imageUrl = snapshot.data!;
                  _imageUrl != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder_image.png',
                          image: _imageUrl!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: null
                          ),
                        ),
                      ],
                    ),
                  )
                      : const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  if (kDebugMode) {
                    print('Error loading image: ${snapshot.error}');
                  }
                  return const Text('Error loading image');
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 10),



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
                    color: Colors.yellow,
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


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _showFullDescription = !_showFullDescription),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
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
