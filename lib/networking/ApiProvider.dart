import './CustomException.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider {
  final String _baseUrl = DotEnv().env['TMDB_API_BASE_URL'];

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      print("getting movies-- ApiProvider");
      final _requestUrl =
          (_baseUrl + url + '?api_key=' + DotEnv().env['TMDB_API_KEY'])
              .toString();
      print(_requestUrl);
      final response = await http.get(_requestUrl);
      responseJson = _response(response);
    } catch (error) {
      print("Inetrnet Error::" + error);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
