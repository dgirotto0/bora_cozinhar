import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../assets/colors/colors.dart';
import '../assets/models/receita_model.dart';
import '../constants/error_message.dart';
import '../constants/gemini.dart';
import '../constants/receita_card.dart';

class ReceitasPage extends StatefulWidget {
  final List<String>? selectedIngredients;

  const ReceitasPage({super.key, this.selectedIngredients, required String initialIngredients});

  @override
  _ReceitasPageState createState() => _ReceitasPageState();
}

class _ReceitasPageState extends State<ReceitasPage> with TickerProviderStateMixin {
  List<Receita> receitas = [];
  late GenerativeModel model;
  late AnimationController _controller;
  final Connectivity _connectivity = Connectivity();

  bool _showLoadingPopup = false;
  bool _noInternet = false;

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: 'YOU_API_HERE', //TODO: your gemini pro api key here
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _checkInternetConnection();
    _buscarReceitas();
  }

  Future<void> _checkInternetConnection() async {
    final connectivityResults = await _connectivity.checkConnectivity();
    if (connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.mobile)) {
      _buscarReceitas();
    } else {
      setState(() {
        _noInternet = true;
      });
    }
  }

  Future<void> _buscarReceitas() async {
    const numeroReceitas = 3  ;

    setState(() {
      _showLoadingPopup = true;
    });

    while (receitas.length < numeroReceitas) {
      await _buscarUmaReceita();
    }

    setState(() {
      _showLoadingPopup = false;
    });
  }

  Future<void> _buscarUmaReceita() async {
    const numeroReceitas = 2;

    for (int i = 0; i < numeroReceitas; i++) {
      if (!mounted) return;

      final generativeAI = GenerativeAI(
        apiKey: 'YOU_API_KEY', //TODO: your gemini pro api key here
      );

      final prompt = "Escreva uma receita com ${widget.selectedIngredients?.join(', ')}";
      final content = [Content.text(prompt)];
      final response = await generativeAI.model.generateContent(content);
      final textoReceitaNomeTempo = response.text;

      final receitaNomeTempoParts = textoReceitaNomeTempo?.split('\n\n');

      // Handle empty or incomplete response
      if (receitaNomeTempoParts == null || receitaNomeTempoParts.length < 2) {
        showErrorMessage('Não foi possível encontrar receitas com esses ingredientes. Tente novamente.');
        continue; // Skip to the next iteration
      }

      final nomeReceita = receitaNomeTempoParts[0];
      final tempoPreparo = receitaNomeTempoParts[1].split(' ')[0];


      final promptCompleto = "Complete a receita $nomeReceita com tempo de preparo de $tempoPreparo minutos, utilizando os ingredientes: ${widget.selectedIngredients?.join(', ')}, varie entre doces e salgados";
      final contentCompleto = [Content.text(promptCompleto)];
      final responseCompleto = await generativeAI.model.generateContent(contentCompleto);
      final textoReceitaCompleta = responseCompleto.text;
      final receitaCompletaParts = textoReceitaCompleta?.split('\n\n');
      final ingredientes = receitaCompletaParts?[1].split('\n')
          .map((ingrediente) => Ingrediente(nome: ingrediente))
          .toList() ?? const [];
      final descricao = receitaCompletaParts!.length > 2
          ? receitaCompletaParts.sublist(2).join('\n')
          : '';


      final receitaMap = {
        "titulo": nomeReceita,
        "tempo_preparo": tempoPreparo,
        "ingredientes": ingredientes.map((i) => i.nome).toList(),
        "modo_de_preparo": descricao,
      };


      final receitaJson = jsonEncode(receitaMap);


      final receita = Receita.fromJson(jsonDecode(receitaJson));

      receitas.add(receita);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller in dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Paleta.fundoBranco,
      appBar: AppBar(
        title: Text(
          'AICook',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            color: Paleta.vermelhoVibrante,
            fontWeight: FontWeight.w500
          ),
        ),
        backgroundColor: Paleta.laranjaSuave,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _noInternet
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40), // Add spacing above the icon
                const Icon(
                  Icons.wifi_off, // Use the wifi_off icon
                  size: 72, // Adjust icon size as needed
                  color: Paleta.vermelhoVibrante, // Set icon color
                ),
                const SizedBox(height: 20), // Add spacing between icon and text
                Text(
                  'Sem conexão com a internet!',
                  style: GoogleFonts.abel(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
              : Center(
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
          receitas.length >= 2 && !_showLoadingPopup ? const SizedBox() : _buildLoadingPopup(),
        ],
      ),
    );
  }

  Widget _buildLoadingPopup() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 250,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            border: Border.all(
              color: Paleta.vermelhoVibrante,
              width: 3,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Paleta.vermelhoVibrante),
                ),
                SizedBox(width: 10),
                Text(
                  'Gerando receitas...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}