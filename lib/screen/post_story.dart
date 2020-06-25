import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/provider/stories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostStoryScreen extends StatefulWidget {
  PostStoryScreen({Key key}) : super(key: key);

  static const routeName = '/post-story';

  @override
  _PostStoryScreenState createState() => _PostStoryScreenState();
}

class _PostStoryScreenState extends State<PostStoryScreen> {
  File _file;
  final picker = ImagePicker();
  String _token;

  Future<void> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = preferences.getString('token');
    });
  }

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(pickedFile.path);
    });
  }

  Future<void> postImage() async {
    await Provider.of<Stories>(context, listen: false)
        .postStory(_file, _token, context)
        .then((value) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Story telah ditambahkan'),
                content: Text('Berhasil'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.popUntil(context, (route) {
                        return route.settings.name == '/';
                      });
                    },
                  )
                ],
              ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('UPLOAD STORY'),
        leading: IconButton(
          icon: Icon(Ionicons.ios_arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Center(
          child: _file == null ? Text('No image selected.') : Image.file(_file),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            _file == null ? Icon(Ionicons.ios_images) : Icon(Ionicons.ios_send),
        onPressed: _file == null ? getImage : postImage,
      ),
    );
  }
}
