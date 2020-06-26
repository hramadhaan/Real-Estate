import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemPost extends StatefulWidget {
  final String images;
  final String title;
  final String name;
  final String photoProfile;

  ItemPost({this.images, this.title, this.name, this.photoProfile});

  @override
  _ItemPostState createState() => _ItemPostState();
}

class _ItemPostState extends State<ItemPost> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AspectRatio(
        aspectRatio: 4 / 2.76,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                CachedNetworkImageProvider(widget.photoProfile),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '15 mins ago',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(widget.images),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.9),
                        Colors.black.withOpacity(.1),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: Text(
                        widget.title,
                        style: TextStyle(color: Colors.white70, fontSize: 11.2),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
