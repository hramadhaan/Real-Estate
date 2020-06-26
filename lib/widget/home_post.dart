import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/main.dart';
import 'package:real_estate/provider/posts.dart';
import 'package:real_estate/widget/item_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePost extends StatefulWidget {
  @override
  _HomePostState createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {
  String token;

  ScrollController _scrollController = new ScrollController();

  Future<void> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
    });
  }

  Future<void> getPost() async {
    await Provider.of<Posts>(context, listen: false).getAllPost(token, 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: FutureBuilder(
          future: getPost(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? ListTileShimmer()
                  : RefreshIndicator(
                      onRefresh: getPost,
                      child: Consumer<Posts>(
                        builder: (ctx, postData, _) => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: postData.items.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (_, i) => ItemPost(
                            images: "http://192.168.1.9:8080/" +
                                postData.items[i].images[0],
                            title: postData.items[i].title,
                            name: postData.items[i].creator.name,
                            photoProfile: "http://192.168.1.9:8080/" +
                                postData.items[i].creator.photo,
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
