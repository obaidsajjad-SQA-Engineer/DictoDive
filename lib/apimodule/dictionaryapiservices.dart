import 'package:getx14_api_integration/productmodule/models/dictionary_model.dart';
import 'package:http/http.dart' as http;

class DictionaryApiService {
  static var client = http.Client();

  static Future<List<DictionaryModel>> fetchDictionary(String word) async {
    var response = await client.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/${word}'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return dictionaryModelFromMap(jsonString);
    } else {
      throw Exception(
          'Failed to load Dictionary. Status code: ${response.statusCode}');
    }
  }
}
