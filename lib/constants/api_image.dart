import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<String?> translateQuery(String query, String targetLanguage) async {
  const translateApiUrl = 'https://translation.googleapis.com/language/translate/v2';
  const translateApiKey = 'AIzaSyAQqfrWhfpPb89rDeNU1y8xNWGLPDmInMI';

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
        print('Falha na tradução da consulta: ${response.body}');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Erro ao traduzir a consulta: $error');
    }
  }
  return null;
}

const pixabayApiKey = '33124447-253fa352a6d76003059187773';

Future<String?> fetchRecipeImage(String recipeName) async {
  const pixabayApiUrl = 'https://pixabay.com/api';

  // Translate the recipe name to English
  final translatedQuery = await translateQuery(recipeName, 'en');
  if (translatedQuery == null) {
    if (kDebugMode) {
      print('Não foi possível traduzir a consulta: $recipeName');
    }
    return null;
  }

  final url = Uri.parse('$pixabayApiUrl?key=$pixabayApiKey&q=${translatedQuery.replaceAll('**', '')}&image_type=photo');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final hits = data['hits'];
      if (hits.isNotEmpty) {
        final imageUrl = hits[0]['webformatURL'];
        return imageUrl;
      } else {
        if (kDebugMode) {
          print('Nenhuma imagem encontrada para: ${recipeName.replaceAll('**', '')}');
        }
      }
    } else {
      if (kDebugMode) {
        print('Erro ao buscar imagem: ${response.statusCode} - ${response.body}');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Erro ao buscar imagem: $error');
    }
  }
  return null;
}