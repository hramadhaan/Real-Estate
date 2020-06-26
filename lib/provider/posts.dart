import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:real_estate/model/post.dart';
import 'package:http/http.dart' as http;

class Posts with ChangeNotifier {
  List<Post> _items = [];

  List<Post> get items {
    return [..._items];
  }

  Future<void> getAllPost(String token, int angka) async {
    final url = 'http://192.168.1.9:8080/all-post';
    try {
      _items.clear();
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token}',
      });
      final data = jsonDecode(response.body);
      print(data);

      final dataResponse = data as List;

      _items = dataResponse.map<Post>((json) => Post.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
