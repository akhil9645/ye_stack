import 'package:dio/dio.dart';

class Diohandler {
  static final Dio dio = Dio();

  static const _headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'application/gzip',
    'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
    'x-rapidapi-key': '3342144d67msh73fba1733a23d0ep1b2602jsnf4b80a1eefe8',
  };

  static Future<dynamic> dioPost({dynamic body, String? path}) async {
    Diohandler.dio.options.headers.addAll(_headers);
    try {
      Response response = await Diohandler.dio
          .post(path!, data: body)
          .timeout(Duration(seconds: 60));

      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw Exception('Request failed: ${e.message}');
      } else {
        throw Exception('Unknown error occurred');
      }
    }
  }

  static Future<dynamic> dioGet({String? path}) async {
    Diohandler.dio.options.headers.addAll(_headers);
    try {
      Response response;
      response = await Diohandler.dio.get(path!).timeout(Duration(seconds: 60));
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
