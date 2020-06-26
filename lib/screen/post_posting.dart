import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:real_estate/main.dart';

class PostPostingScreen extends StatefulWidget {
  static const routeName = '/post';

  @override
  _PostPostingScreenState createState() => _PostPostingScreenState();
}

class _PostPostingScreenState extends State<PostPostingScreen> {
  File _image;
  String _title;
  GlobalKey<FormState> _key = GlobalKey();
  List<Asset> images = List<Asset>();

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: false,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: '#000000',
          actionBarTitle: 'Real Estate',
          lightStatusBar: false,
          statusBarColor: '#000000',
          actionBarTitleColor: '#ffffff',
          allViewTitle: 'Semua Photo',
          useDetailsView: false,
          selectCircleStrokeColor: '#000000',
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPLOAD POST'),
        elevation: 0,
        leading: IconButton(
          hoverColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Ionicons.ios_arrow_back,
          ),
        ),
      ),
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 3,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  onSaved: (value) => _title = value,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Apa yang anda pikirkan ?',
                    hintStyle: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  minLines: 4,
                  maxLines: 5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 2,
                  childAspectRatio: 3 / 3,
                  crossAxisCount: 4,
                  children: List.generate(images.length, (index) {
                    Asset asset = images[index];
                    return AssetThumb(
                      asset: asset,
                      width: 300,
                      height: 300,
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: images.isEmpty
            ? Icon(Ionicons.ios_images)
            : Icon(Ionicons.ios_send),
        onPressed: images.isEmpty ? loadAssets : null,
      ),
    );
  }
}
