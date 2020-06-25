import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:real_estate/screen/home_screen.dart';
import 'package:real_estate/screen/post_story.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  String title = 'HOME';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Ionicons.ios_camera),
            onPressed: () {
              Navigator.of(context).pushNamed(PostStoryScreen.routeName);
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Ionicons.ios_notifications_outline,
              ),
            )
          ],
          centerTitle: true,
          title: Text(
            title,
          ),
          elevation: 0,
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;

              switch (index) {
                case 0:
                  title = 'HOME';
                  break;
                case 1:
                  title = 'SEARCH';
                  break;
                case 2:
                  title = 'PROFILE';
                  break;
              }
            });
          },
          children: <Widget>[
            HomeScreen(),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 55,
        iconSize: 20,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutExpo);

            switch (index) {
              case 0:
                title = 'HOME';
                break;
              case 1:
                title = 'SEARCH';
                break;
              case 2:
                title = 'PROFILE';
                break;
            }
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text(
              'Home',
              style: TextStyle(),
            ),
            icon: Icon(Ionicons.ios_home),
            activeColor: Colors.black,
            inactiveColor: Colors.black26,
          ),
          BottomNavyBarItem(
            title: Text('Search'),
            icon: Icon(Ionicons.ios_search),
            activeColor: Colors.black,
            inactiveColor: Colors.black26,
          ),
          BottomNavyBarItem(
            title: Text('Profile'),
            icon: Icon(Ionicons.ios_person),
            activeColor: Colors.black,
            inactiveColor: Colors.black26,
          ),
        ],
      ),
    );
  }
}
