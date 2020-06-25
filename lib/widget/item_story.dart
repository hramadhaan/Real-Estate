import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemStory extends StatelessWidget {
  ItemStory({this.storyImage, this.userImage, this.userName});
  final String storyImage;
  final String userImage;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: AspectRatio(
        aspectRatio: 1.32 / 2,
        child: Hero(
          tag: storyImage,
          child: Container(
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(storyImage),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    offset: Offset(2, -2),
                  )
                ]),
            child: Container(
              padding: EdgeInsets.only(
                bottom: 9,
                top: 4,
                left: 4,
                right: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.1),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(userImage),
                      ),
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
