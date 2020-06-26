import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/provider/stories.dart';
import 'package:real_estate/widget/item_story.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../main.dart';

class HomeStory extends StatefulWidget {
  @override
  _HomeStoryState createState() => _HomeStoryState();
}

class _HomeStoryState extends State<HomeStory> {
  String token;

  Future<void> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
    });
  }

  Future<void> _refreshStory() async {
    await Provider.of<Stories>(context, listen: false).seeStory(token);
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: FutureBuilder(
        future: _refreshStory(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? PlayStoreShimmer()
                : Container(
                    height: 158,
                    margin: EdgeInsets.only(right: 8),
                    child: RefreshIndicator(
                      onRefresh: () => _refreshStory(),
                      child: Consumer<Stories>(
                        builder: (ctx, storyDaata, _) => Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: storyDaata.items.length,
                                itemBuilder: (_, i) => ItemStory(
                                  userName: storyDaata.items[i].creator.name,
                                  storyImage: "http://192.168.1.9:8080/" +
                                      storyDaata.items[i].image,
                                  userImage: "http://192.168.1.9:8080/" +
                                      storyDaata.items[i].creator.photo,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
