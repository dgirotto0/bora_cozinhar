import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constants/ingredients_controller.dart';
import '../../constants/language_state.dart';

class BasePage extends StatefulWidget {
  final String pageTitle;
  final List<String> ingredientNames;
  final Widget nextPage;
  const BasePage({
    super.key,
    required this.pageTitle,
    required this.ingredientNames,
    required this.nextPage,
  });

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late LanguageState languageState;
  String _currentTitle = '';
  List<String> _currentIngredientNames = [];

  @override
  void initState() {
    super.initState();
    languageState = Provider.of<LanguageState>(context, listen: false);
    _currentTitle = widget.pageTitle;
    _currentIngredientNames = widget.ingredientNames;
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = languageState.isEnglish;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          isEnglish ? "AICook" : 'AICook',
          style: GoogleFonts.montserrat(fontSize: 20, color: Colors.yellow),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.translate,
              color: Colors.yellow,
            ),
            onPressed: () async {
              languageState.toggleLanguage();
              if (isEnglish) {
                final translatedTitle = await translateQuery(widget.pageTitle, 'en');
                setState(() {
                  _currentTitle = translatedTitle ?? widget.pageTitle;
                }); // Update title first

                final translatedIngredients = await Future.wait(
                    widget.ingredientNames.map((ingredient) => translateQuery(ingredient, 'en').then((result) => result ?? '')));
                setState(() {
                  _currentIngredientNames = translatedIngredients.toList();
                });
              } else {

                setState(() {
                  _currentTitle = widget.pageTitle;
                  _currentIngredientNames = widget.ingredientNames;
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _currentTitle,
                  style: GoogleFonts.abel(
                      fontSize: 28,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ...buildIngredientCheckboxList(context, isEnglish),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => widget.nextPage),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text('Next',
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<String?> translateQuery(String query, String targetLanguage) async {
    const translateApiUrl = 'https://translation.googleapis.com/language/translate/v2';
    const translateApiKey = 'AIzaSyAQqfrWhfpPb89rDeNU1y8xNWGLPDmInMI'; // Replace with your actual key
    final url = Uri.parse('$translateApiUrl?key=$translateApiKey');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'q': query,
            'target': targetLanguage,
          }));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translatedText = data['data']['translations'][0]['translatedText'];
        return translatedText;
      } else {
        if (kDebugMode) {
          print('Failed to translate query: ${response.body}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error translating query: $error');
      }
    }
    return null;
  }

  List<Widget> buildIngredientCheckboxList(BuildContext context, bool isEnglish) {
    return _currentIngredientNames.map((ingredientName) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10)),
            child: Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.grey[400],
              ),
              child: CheckboxListTile(
                title: Text(
                  ingredientName,
                  style: GoogleFonts.abel(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                value:
                    Provider.of<IngredientsController>(context, listen: false)
                        .selectedVegetables
                        .contains(ingredientName),
                onChanged: (newValue) {
                  List<String> newIngredients = List.from(
                      Provider.of<IngredientsController>(context, listen: false)
                          .selectedVegetables);
                  if (newValue!) {
                    newIngredients.add(ingredientName);
                  } else {
                    newIngredients.remove(ingredientName);
                  }
                  Provider.of<IngredientsController>(context, listen: false)
                      .updateSelectedVegetables(newIngredients);
                },
                activeColor: Colors.yellow,
                checkColor: Colors.black,
                controlAffinity: ListTileControlAffinity.platform,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ));
    }).toList();
  }
}
