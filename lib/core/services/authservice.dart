import 'dart:convert';
import 'package:http/http.dart';

import 'package:rhema_rapha_app/core/constants/endpoints.dart';
import 'package:rhema_rapha_app/core/constants/localkeys.dart';
import 'package:rhema_rapha_app/core/message/result.model.dart';
import 'package:rhema_rapha_app/core/models/signin.model.dart';
import 'package:rhema_rapha_app/core/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const timeoutSeconds = 10;

  Future<bool> signout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var email = await getUserLoggedEmail();
    sharedPreferences.clear();
    sharedPreferences.setBool(ONBOARDING, true);
    sharedPreferences.setString(EMAIL, email);
    return true;
  }

   static Future<bool> isOnboarded() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var onboarding = sharedPreferences.getBool(ONBOARDING);
    if (onboarding == null) return false;
    return onboarding;
  }

  Future<Result> signin(SignIn user) async {
    try {
      var baseurl = EndPoints.getBaseUrl();

      var res = await post('$baseurl/auth/login', body: user.toJson()).timeout(
        const Duration(seconds: timeoutSeconds),
        onTimeout: () => onTimeout(),
      );

      if (res != null && res.statusCode == 200) {
        var decodedData = jsonDecode(res.body);
        var data = decodedData['data'];

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(TOKEN, jsonEncode(data['token']));
        sharedPreferences.setString(AUTHDATA, jsonEncode(data['dbUser']));
        sharedPreferences.setString(EMAIL, jsonEncode(data['dbUser']));

        return Result(
            isSuccessful: true, data: data, message: 'Signin successful');
      }

      if (res != null && res.statusCode == 400) {
        Map<String, dynamic> message = jsonDecode(res.body);
        print(message['message']);

        var errorMessage = message['message'] == null
            ? "Please Check Your Connection"
            : message['message'];

        var data = jsonDecode(res.body);

        return Result(isSuccessful: false, data: data, message: errorMessage);
      }

      return Result(isSuccessful: false, message: 'Please Check Your Connection');
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Result> signup(User user) async {
    var baseurl = EndPoints.getBaseUrl();
    var body = user.toJson();
    var res = await post('$baseurl/auth/register', body: body).timeout(
      const Duration(seconds: timeoutSeconds),
      onTimeout: () => onTimeout(),
    );

    if (res != null && res.statusCode == 201) {
      var decodedData = jsonDecode(res.body);
      var data = decodedData['data'];

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(TOKEN, jsonEncode(data['token']));
      sharedPreferences.setString(AUTHDATA, jsonEncode(data['dbUser']));
      sharedPreferences.setString(USER_ID, jsonEncode(data['dbUser']['id']));

      return Result(
          isSuccessful: true, data: data, message: 'Signin successful');
    }

    if (res != null && res.statusCode == 400) {
      Map<String, dynamic> message = jsonDecode(res.body);
      print(message['message']);

      var errorMessage =
          message['message'] == null ? "Error Signing up" : message['message'];

      var data = jsonDecode(res.body);

      return Result(isSuccessful: false, data: data, message: errorMessage);
    }
    return Result(isSuccessful: false, message: 'Please Check Your Connection');
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString(AUTHDATA));

    var user = sharedPreferences.getString(AUTHDATA);
    var patient = jsonDecode(user);
    return patient;
  }

  Future<bool> changePassword(String email) async {
    var baseurl = EndPoints.getBaseUrl();
    var res = await post('$baseurl/rest-auth/password/change/').timeout(
      const Duration(seconds: timeoutSeconds),
      onTimeout: () => onTimeout(),
    );
    if (res != null && res.statusCode == 200) {
      print(res.body);
      return true;
    }
    return false;
  }

  // Future<bool> signout() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var email = await getUserLoggedEmail();
  //   var seenUpdate = sharedPreferences.getBool(SEENUPDATE);
  //   sharedPreferences.clear();
  //   sharedPreferences.setBool(ONBOARDING, true);
  //   sharedPreferences.setString(EMAIL, email);
  //   sharedPreferences.setBool(SEENUPDATE, seenUpdate);
  //   return true;
  // }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool exits = sharedPreferences.containsKey(AUTHDATA);
    if (!exits) return '';

    var sharedPreferencesAuthData = sharedPreferences.get(AUTHDATA);
    var authData = jsonDecode(sharedPreferencesAuthData);
    return authData['token'];
  }

  Future<String> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool exits = sharedPreferences.containsKey(AUTHDATA);
    if (!exits) return '';

    var sharedPreferencesAuthData = sharedPreferences.get(AUTHDATA);
    var authData = jsonDecode(sharedPreferencesAuthData);
    return authData['id'];
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool exits = sharedPreferences.containsKey(TOKEN);
    return exits;
  }

  static Future<String> getUserEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getString(AUTHDATA);
    var email = jsonDecode(user)['email'] as String;
    return email;
  }

  static Future<String> getUserLoggedEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var tempEmail = sharedPreferences.getString(EMAIL);
    var email = jsonDecode(tempEmail);

    return email;
  }


  onTimeout() {
    print('************* Connection Failed');
  }
}
