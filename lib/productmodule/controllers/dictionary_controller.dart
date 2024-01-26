// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:getx14_api_integration/apimodule/dictionaryapiservices.dart';
import 'package:getx14_api_integration/productmodule/models/dictionary_model.dart';

class DictionaryController extends GetxController {
  var isLoading = true.obs;
  var dictionaryList = <DictionaryModel>[].obs;

  @override
  void onInit() {
    fetchDictionary("");
    super.onInit();
  }

  Future<void> fetchDictionary(String word) async {
    try {
      isLoading.value = true;
      var products = await DictionaryApiService.fetchDictionary(word);
      if (products != null) {
        dictionaryList.assignAll(products);
      } else {
        print('Error: Unable to fetch Dictionary.');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
