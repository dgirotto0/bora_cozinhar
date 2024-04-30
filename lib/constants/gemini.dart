import 'package:google_generative_ai/google_generative_ai.dart';

class GenerativeAI {
  final String apiKey;
  final GenerativeModel model;

  GenerativeAI({required this.apiKey}) : model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
}

