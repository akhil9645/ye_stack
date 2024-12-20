import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ye_stack/controller/dio_handler.dart';

class ApiServiceController extends GetxController {
  static const _baseUrl =
      "https://google-translate1.p.rapidapi.com/language/translate/v2";

  Rx<String> sourceLanguage = ''.obs;
  Rx<String> targetLanguage = ''.obs;
  Rx<String> translatedText = ''.obs;

  fetchLanguages() async {
    final response = await Diohandler.dioGet(path: "$_baseUrl/languages");

    if (response != null &&
        response['data'] != null &&
        response['data']['languages'] != null) {
      return response['data']['languages'];
    } else {
      throw Exception('Failed to load languages. Response: $response');
    }
  }

  translateText(String text, String target) async {
    var body = {'q': text, 'target': target, 'source': 'en'};
    try {
      final response = await Diohandler.dioPost(body: body, path: _baseUrl);
      if (response != null && response['data'] != null) {
        return response['data']['translations'][0]['translatedText'];
      } else {
        throw Exception('Failed to translate text');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Translation request failed: ${e.message}');
      } else {
        throw Exception('Failed to translate text');
      }
    }
  }
}
