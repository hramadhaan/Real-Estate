import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/provider/stories.dart';
import 'package:real_estate/provider/users.dart';
import 'package:real_estate/screen/home_screen.dart';
import 'package:real_estate/screen/login_screen.dart';
import 'package:real_estate/screen/main_screen.dart';
import 'package:real_estate/screen/post_story.dart';
import 'package:real_estate/screen/splash_screen.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: User()),
        ChangeNotifierProvider.value(value: Stories()),
      ],
      child: Consumer<User>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? MainScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          theme: ThemeData(
              primaryColor: Colors.white,
              fontFamily: 'OpenSans',
              primaryTextTheme: TextTheme(
                  title: TextStyle(
                fontFamily: 'Krona',
                fontSize: 12,
                color: Colors.black,
              ))),
          routes: {
            PostStoryScreen.routeName: (ctx) => PostStoryScreen(),
          },
        ),
      ),
    );
  }
}
