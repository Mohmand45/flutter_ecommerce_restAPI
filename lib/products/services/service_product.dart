import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rest_api/utilities/rest_api_utilities.dart';

import '../models/model_post.dart';

class ServiceProduct {
  static var client = http.Client();
  static var duration = Duration(seconds: 10);

  static Future<List<ModelPost>> LoadProducts() async {
    List<ModelPost> list = [];

    try {
      Map<String, String> header = {};
      Map<String, String> body = {};

      Response response = await client
          .get(Uri.parse(RestApiUtilities.product_url))
          .timeout(duration);

      RestApiUtilities.GetPrintHeaderBodyUrlResponse(
          RestApiUtilities.product_url, header, body, response);

      if (response.statusCode == 200) {
        list = modelPostFromMap(response.body);
        return list;
      } else {
        if (response == 404) {
          print("Response sorry resource not found");
        } else {
          print("Response sorry ${response.body}");
        }
        print(RestApiUtilities.GetResponseError(response.statusCode));
        return list;
      }
    } on TimeoutException {
      print(RestApiUtilities.GetResponseError(420));
      return list;
    } on SocketException {
      print(RestApiUtilities.GetResponseError(430));
      return list;
    } catch (e) {
      print("Error ${e.toString()}");
      return list;
    }
  }
}
