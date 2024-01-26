// To parse this JSON data, do
//
//     final dictionaryModel = dictionaryModelFromMap(jsonString);

import 'dart:convert';

List<DictionaryModel> dictionaryModelFromMap(String str) =>
    List<DictionaryModel>.from(
        json.decode(str).map((x) => DictionaryModel.fromMap(x)));

String dictionaryModelToMap(List<DictionaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DictionaryModel {
  String? word;
  String? phonetic;
  List<Phonetic>? phonetics;
  String? origin;
  List<Meaning>? meanings;

  DictionaryModel({
    this.word,
    this.phonetic,
    this.phonetics,
    this.origin,
    this.meanings,
  });

  factory DictionaryModel.fromMap(Map<String, dynamic> json) => DictionaryModel(
        word: json["word"],
        phonetic: json["phonetic"],
        phonetics: json["phonetics"] == null
            ? []
            : List<Phonetic>.from(
                json["phonetics"]!.map((x) => Phonetic.fromMap(x))),
        origin: json["origin"],
        meanings: json["meanings"] == null
            ? []
            : List<Meaning>.from(
                json["meanings"]!.map((x) => Meaning.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "word": word,
        "phonetic": phonetic,
        "phonetics": phonetics == null
            ? []
            : List<dynamic>.from(phonetics!.map((x) => x.toMap())),
        "origin": origin,
        "meanings": meanings == null
            ? []
            : List<dynamic>.from(meanings!.map((x) => x.toMap())),
      };
}

class Meaning {
  String? partOfSpeech;
  List<Definition>? definitions;
  List<dynamic>? synonyms;
  List<dynamic>? antonyms;

  Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  factory Meaning.fromMap(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: json["definitions"] == null
            ? []
            : List<Definition>.from(
                json["definitions"]!.map((x) => Definition.fromMap(x))),
        synonyms: json["synonyms"] == null
            ? []
            : List<dynamic>.from(json["synonyms"]!.map((x) => x)),
        antonyms: json["antonyms"] == null
            ? []
            : List<dynamic>.from(json["antonyms"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "partOfSpeech": partOfSpeech,
        "definitions": definitions == null
            ? []
            : List<dynamic>.from(definitions!.map((x) => x.toMap())),
        "synonyms":
            synonyms == null ? [] : List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms":
            antonyms == null ? [] : List<dynamic>.from(antonyms!.map((x) => x)),
      };
}

class Definition {
  String? definition;
  String? example;
  List<dynamic>? synonyms;
  List<dynamic>? antonyms;

  Definition({
    this.definition,
    this.example,
    this.synonyms,
    this.antonyms,
  });

  factory Definition.fromMap(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        example: json["example"],
        synonyms: json["synonyms"] == null
            ? []
            : List<dynamic>.from(json["synonyms"]!.map((x) => x)),
        antonyms: json["antonyms"] == null
            ? []
            : List<dynamic>.from(json["antonyms"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "definition": definition,
        "example": example,
        "synonyms":
            synonyms == null ? [] : List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms":
            antonyms == null ? [] : List<dynamic>.from(antonyms!.map((x) => x)),
      };
}

class Phonetic {
  String? text;
  String? audio;
  String? sourceUrl;

  Phonetic({
    this.text,
    this.audio,
    this.sourceUrl,
  });

  factory Phonetic.fromMap(Map<String, dynamic> json) => Phonetic(
        text: json["text"],
        audio: json["audio"],
        sourceUrl: json["sourceUrl"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "audio": audio,
        "sourceUrl": sourceUrl,
      };
}
