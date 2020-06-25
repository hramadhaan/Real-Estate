import 'package:flutter/material.dart';

class HomeInput extends StatelessWidget {
  const HomeInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        bottom: 5,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          print('Apa yang anda pikirkan');
        },
        style: TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: 'Apa yang anda pikirkan ?',
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
