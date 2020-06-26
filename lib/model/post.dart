import 'package:flutter/foundation.dart';
import 'package:real_estate/model/story.dart';

class Post with ChangeNotifier {
  List<String> images;
  String id;
  String title;
  Creator creator;
  String createdAt;

  Post({this.images, this.id, this.title, this.creator, this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      images: List.from(json['images']),
      id: json['_id'],
      title: json['title'],
      creator: Creator.fromJson(json['creator']),
      createdAt: json['createdAt'],
    );
  }
}
