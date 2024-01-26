// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx14_api_integration/productmodule/views/dictionary_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx14_api_integration/productmodule/utils/constants.dart';
import 'package:getx14_api_integration/productmodule/views/dictionarysplash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: fetchApiData,
      theme: ThemeData(
        primarySwatch: blueColor,
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: isOnboardingCompleted(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true
                ? DictionaryView()
                : DictionarySplash();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

Future<bool> isOnboardingCompleted() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('onboardingCompleted') ?? false;
}
