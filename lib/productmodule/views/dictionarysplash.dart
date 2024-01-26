// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx14_api_integration/productmodule/controllers/splash_controller.dart';

class DictionarySplash extends StatelessWidget {
  const DictionarySplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DictionarySplashController>(
      init: DictionarySplashController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Image.asset("assets/logo.png"),
          ),
        );
      },
    );
  }
}
