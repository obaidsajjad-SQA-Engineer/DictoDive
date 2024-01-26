import 'dart:async';

import 'package:get/get.dart';

import '../views/dictionaryonboarding01.dart';

class DictionarySplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Call the function to navigate after 3 seconds
    Timer(Duration(seconds: 3), () {
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    Get.to(() => DictionaryOnboarding01());
  }
}
