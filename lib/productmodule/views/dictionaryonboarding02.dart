// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx14_api_integration/productmodule/views/dictionary_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx14_api_integration/productmodule/views/dictionaryonboarding01.dart';

class DictionaryOnboarding02 extends StatelessWidget {
  const DictionaryOnboarding02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Function to navigate to DictionaryOnboarding01 after 5 seconds
    void navigateToPreviousScreen() {
      Get.to(() => DictionaryOnboarding01());
    }

    // Delayed navigation after 5 seconds
    Timer timer = Timer(Duration(seconds: 5), () {
      navigateToPreviousScreen();
    });
    timer.cancel();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Image.asset(
              "assets/02.png",
              height: 250,
            ),
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Text(
                  "Word Wisdom Unleashed",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 340,
                  child: Text(
                    "Dive into a world of language mastery with DictoDive, where every word becomes an exploration, and knowledge is just a tap away",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 72, 72, 72),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(300, 50),
                ),
              ),
              onPressed: () async {
                // Set onboarding completion flag
                await setOnboardingCompleted();
                // Navigate to DictionaryView
                timer.cancel();
                Get.offAll(() => DictionaryView());
              },
              child: Text("Get Started"),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> setOnboardingCompleted() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboardingCompleted', true);
}
