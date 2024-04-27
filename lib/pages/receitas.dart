import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import '../assets/colors/colors.dart';
import '../assets/models/receita_model.dart';
import '../constants/ingredients_controller.dart';
import '../constants/receita_card.dart';

class ReceitasPage extends StatefulWidget {
  final String? initialIngredients;
  final TextEditingController? controller;

  const ReceitasPage({Key? key, this.initialIngredients, this.controller}) : super(key: key);

  @override
  _ReceitasPageState createState() => _ReceitasPageState();
}

class _ReceitasPageState extends State<ReceitasPage> {
  IngredientsController? ingredientsController;
  List<String> ingredientesDisponiveis = [];
  List<Receita> receitas = [];

  @override
  void initState() {
    super.initState();
    ingredientsController = Provider.of<IngredientsController>(context, listen: false);
  }

  void buscarReceitas() async {
    // Limpar lista de receitas
    receitas.clear();

    // Para cada ingrediente disponível, fazer consulta à API do Gemini
    for (final ingrediente in ingredientesDisponiveis) {
      final prompt = "Escreva uma receita de $ingrediente";
      final model = GenerativeModel(model: 'gemini-pro', apiKey: 'AIzaSyBe9bB9sVNsJcxCADMUMz5NcBWscDAm9AY');
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      final textoReceita = response.text;

      // Filtrar receitas que contenham ingredientes disponíveis
      final receita = Receita(
        nome: 'Receita com $ingrediente',
        tempoPreparo: '20',
        // Tempo de preparo genérico
        ingredientes: [Ingrediente(quantidade: '1', nome: ingrediente)],
        // Adicionar o ingrediente principal
        descricao: textoReceita!,
        imagemUrl: 'https://placehold.co/300x300', // Imagem genérica
      );

      // Adicionar receita à lista
      receitas.add(receita);
    }

    // Filtrar receitas por ingredientes disponíveis
    setState(() {});
  }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título da seção de receitas
            Text(
              'Receitas com os Ingredientes Selecionados',
              style: GoogleFonts.abel(
                fontSize: 20,
                color: Paleta.yellow,
              ),
            ),
            const SizedBox(height: 20),

            // Campo de texto para inserir ingredientes
            TextField(
              decoration: const InputDecoration(
                hintText:
                    'Informe os ingredientes que você possui (separados por vírgula)',
              ),
              controller: widget.controller?.text != null ? widget.controller : TextEditingController(),
              onChanged: (text) {
                ingredientesDisponiveis =
                    text.split(',').map((e) => e.trim()).toList();
              },
            ),
            const SizedBox(height: 20),

            // Botão para buscar receitas
            ElevatedButton(
              onPressed: buscarReceitas,
              child: const Text('Buscar Receitas'),
            ),
            const SizedBox(height: 20),

            // Exibir as receitas
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
    );
  }
}
