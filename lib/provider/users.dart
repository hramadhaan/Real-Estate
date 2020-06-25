import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String _message;
  String _token;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    final url = 'http://192.168.1.9:8080/login';
    try {
      Dio dio = new Dio();
      dio.options.contentType = 'application/json';
      await dio.post(url, data: {
        'email': email,
        'password': password,
      }).then((value) async {
        final response = value.data;
        print(response);

        _token = response['token'];
        _userId = response['userId'];
        notifyListeners();
        final pref = await SharedPreferences.getInstance();
        pref.setString("token", _token);
        pref.setString("userId", _userId);
      }).catchError((err) => print(err));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return false;
    }
    final extractedData = prefs.getString('token');
    _token = extractedData;
    notifyListeners();
    return true;
  }
}
