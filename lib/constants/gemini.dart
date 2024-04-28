import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GenerativeAI {
  final String apiKey;
  final GenerativeModel model;

  GenerativeAI({required this.apiKey}) : model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
}

void main() async {
  final ai = GenerativeAI(apiKey: 'AIzaSyBe9bB9sVNsJcxCADMUMz5NcBWscDAm9AY');
}
