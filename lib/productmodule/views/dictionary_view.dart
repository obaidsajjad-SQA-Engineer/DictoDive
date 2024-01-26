// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx14_api_integration/productmodule/controllers/dictionary_controller.dart';
import 'package:getx14_api_integration/productmodule/utils/constants.dart';
import 'package:just_audio/just_audio.dart';

class DictionaryView extends StatefulWidget {
  DictionaryView({super.key});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  DictionaryController dictionaryController = Get.put(DictionaryController());

  TextEditingController searchController = TextEditingController();

  final _player = AudioPlayer();

  bool audioPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dictionaryTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                elevation: MaterialStatePropertyAll(0.5),
                controller: searchController,
                trailing: [
                  IconButton(
                    onPressed: () {
                      dictionaryController
                          .fetchDictionary(searchController.text);
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
                hintText: "Search here...",
              ),
            ),
            Obx(
              () {
                if (dictionaryController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: dictionaryController.dictionaryList.length,
                    itemBuilder: (context, wordIndex) {
                      return Column(
                        children: [
                          Divider(
                            height: 50,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Information ${wordIndex + 1} of ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 26),
                              children: [
                                TextSpan(
                                  text:
                                      '${dictionaryController.dictionaryList[wordIndex].word}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: dictionaryController
                                .dictionaryList[wordIndex].phonetics?.length,
                            itemBuilder: (context, phoneticsIndex) {
                              return Column(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          'Pronunciation Text ${phoneticsIndex + 1}: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${dictionaryController.dictionaryList[wordIndex].phonetics?[phoneticsIndex].text}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  dictionaryController
                                              .dictionaryList[wordIndex]
                                              .phonetics?[phoneticsIndex]
                                              .audio ==
                                          ''
                                      ? Text.rich(
                                          TextSpan(
                                            text:
                                                'Pronunciation Audio ${phoneticsIndex + 1}: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'No Audio Available',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Pronunciation Audio ${phoneticsIndex + 1}: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (!audioPlaying) {
                                                  //TODO: SetState equivalent in GetX
                                                  audioPlaying = true;

                                                  await _player.setUrl(
                                                    '${dictionaryController.dictionaryList[wordIndex].phonetics?[phoneticsIndex].audio}',
                                                  );
                                                  await _player.play();

                                                  audioPlaying = false;
                                                }
                                              },
                                              child: audioPlaying
                                                  ? Icon(Icons.pause)
                                                  : Icon(Icons.play_arrow),
                                            ),
                                          ],
                                        ),
                                  Text.rich(
                                    TextSpan(
                                      text: "Source of Audio: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${dictionaryController.dictionaryList[wordIndex].phonetics?[phoneticsIndex]}',
                                          //TODO: Add .source,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /* TextButton(
                                    onPressed: () async {
                                      final Uri url =
                                          Uri.parse('https://flutter.dev');
                                      if (!await launchUrl(url)) {
                                        throw Exception('Could not launch $url');
                                      }
                                    },
                                    child: Text('Source of Audio'),
                                  ), */
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          "License Name: ${phoneticsIndex + 1}: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${dictionaryController.dictionaryList[wordIndex].phonetics?[phoneticsIndex]}',
                                          //TODO: Add .license.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          "License Url ${phoneticsIndex + 1}: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${dictionaryController.dictionaryList[wordIndex].phonetics?[phoneticsIndex]}',
                                          //TODO: Add .license.url,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: dictionaryController
                                .dictionaryList[wordIndex].meanings?.length,
                            itemBuilder: (context, meaningIndex) {
                              return Column(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Part of Speech: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '${dictionaryController.dictionaryList[wordIndex].meanings?[meaningIndex].partOfSpeech}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dictionaryController
                                        .dictionaryList[wordIndex]
                                        .meanings![meaningIndex]
                                        .definitions
                                        ?.length,
                                    itemBuilder: (context, definitionIndex) {
                                      return Column(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  "Definition ${definitionIndex + 1}: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${dictionaryController.dictionaryList[wordIndex].meanings?[meaningIndex].definitions?[definitionIndex].definition}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  "Example ${definitionIndex + 1}: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${dictionaryController.dictionaryList[wordIndex].meanings?[meaningIndex].definitions?[definitionIndex].definition}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      );
                                    },
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dictionaryController
                                        .dictionaryList[wordIndex]
                                        .meanings![meaningIndex]
                                        .synonyms
                                        ?.length,
                                    itemBuilder: (context, synonymIndex) {
                                      return Column(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  "Synonym ${synonymIndex + 1}: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${dictionaryController.dictionaryList[wordIndex].meanings?[meaningIndex].synonyms?[synonymIndex]}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: dictionaryController
                                        .dictionaryList[wordIndex]
                                        .meanings![meaningIndex]
                                        .antonyms
                                        ?.length,
                                    itemBuilder: (context, antonymIndex) {
                                      return Column(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  "Antonym ${antonymIndex + 1}: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${dictionaryController.dictionaryList[wordIndex].meanings?[meaningIndex].antonyms?[antonymIndex]}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20),
                                ],
                              );
                            },
                          ),
                          Divider(
                            height: 30,
                            thickness: 2,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
