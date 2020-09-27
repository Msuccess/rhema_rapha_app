import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rhema_rapha_app/core/services/util.service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:rhema_rapha_app/core/constants/localkeys.dart';

class BaseService {
  static const timeoutSeconds = 30;

  Future<String> getHearders() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var apiToken = sharedPreferences.getString(TOKEN);
    var token = jsonDecode(apiToken);

    return token["token"];
  }

  Future<http.Response> getRequest(url) async {
    try {
      var token = await getHearders();
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ).timeout(
        const Duration(seconds: timeoutSeconds),
        onTimeout: () => onTimeout(),
      );

      print('>>>>>>>>>>> get begins');
      print(url);
      if (response != null) {
        print(response.statusCode);
        print(response.body);
      }
      print('>>>>>>>>>>> get ends');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> postRequest(url, body) async {
    try {
      var token = await getHearders();
      final response = await http
          .post(url,
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(body))
          .timeout(
            const Duration(seconds: timeoutSeconds),
            onTimeout: () => onTimeout(),
          );

      print('>>>>>>>>>>> get begins');
      print(url);
      if (response != null) {
        print(response.statusCode);
        print(response.body);
      }
      print('>>>>>>>>>>> get ends');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> deleteRequest(url) async {
    try {
      var token = await getHearders();
      final response = await http.put(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: timeoutSeconds),
        onTimeout: () => onTimeout(),
      );

      print('>>>>>>>>>>> get begins');
      print(url);
      if (response != null) {
        print(response.statusCode);
        print(response.body);
      }
      print('>>>>>>>>>>> get ends');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> putRequest(url, body) async {
    try {
      var token = await getHearders();
      final response = await http
          .put(url,
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(body))
          .timeout(
            const Duration(seconds: timeoutSeconds),
            onTimeout: () => onTimeout(),
          );

      print('>>>>>>>>>>> get begins');
      print(url);
      if (response != null) {
        print(response.statusCode);
        print(response.body);
      }
      print('>>>>>>>>>>> get ends');
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  onTimeout() {
    print('************* Connection Failed');
    UtilService.showErrorToast('Connection Failed');
  }
}
