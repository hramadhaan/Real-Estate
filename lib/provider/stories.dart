import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/model/story.dart';
import 'package:http/http.dart' as http;

class Stories with ChangeNotifier {
  String message;
  List<Story> _items = [];

  List<Story> get items {
    return [..._items];
  }

  Future<void> postStory(File image, String token, BuildContext bcx) async {
    final url = 'http://192.168.1.9:8080/post-story';
    try {
      _items.clear();

      String filename = image.path.split('/').last;

      FormData data = FormData.fromMap({
        "photo": await MultipartFile.fromFile(image.path, filename: filename),
      });
      Dio dio = new Dio();
      dio.options.contentType = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer ${token}';
      await dio.post(url, data: data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> seeStory(String token) async {
    final url = 'http://192.168.1.9:8080/see-story';
    try {
      _items.clear();
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token}',
      });
      final data = jsonDecode(response.body);
      final message = data['message'] as String;
      if (message.contains('Story tidak ada.')) {
        print(message);
      } else {
        final dataResponse = data['data'] as List;

        _items =
            dataResponse.map<Story>((json) => Story.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
