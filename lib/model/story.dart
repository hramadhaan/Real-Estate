import 'dart:io';

import 'package:flutter/foundation.dart';

class Story with ChangeNotifier {
  String id;
  String image;
  Creator creator;
  String createdAt;

  Story({this.id, this.image, this.creator, this.createdAt});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['_id'],
      image: json['image'],
      creator: Creator.fromJson(json['creator']),
      createdAt: json['createdAt'],
    );
  }
}

class Creator with ChangeNotifier {
  String id;
  String name;
  String photo;

  Creator({this.id, this.name, this.photo});

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['_id'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
    );
  }
}
