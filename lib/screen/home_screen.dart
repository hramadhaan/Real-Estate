import 'package:flutter/material.dart';
import 'package:real_estate/widget/home_input.dart';
import 'package:real_estate/widget/home_story.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xffe8e9e9),
        padding: EdgeInsets.only(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            HomeInput(),
            SizedBox(
              height: 9,
            ),
            HomeStory(),
          ],
        ),
      ),
    );
  }
}
