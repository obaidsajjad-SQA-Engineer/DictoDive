// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx14_api_integration/productmodule/views/dictionary_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getx14_api_integration/productmodule/views/dictionaryonboarding02.dart';

class DictionaryOnboarding01 extends StatelessWidget {
  const DictionaryOnboarding01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Function to navigate to DictionaryOnboarding02 after 5 seconds
    void navigateToNextScreen() {
      Get.to(() => DictionaryOnboarding02());
    }

    // Delayed navigation after 5 seconds
    Timer timer = Timer(Duration(seconds: 5), () {
      navigateToNextScreen();
    });

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
              "assets/01.png",
              height: 250,
            ),
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Text(
                  "Welcome to DictoDive",
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
                    "Unlock the power of words with DictoDive Your comprehensive dictionary app for exploring the intricacies of language",
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
