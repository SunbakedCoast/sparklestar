import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width,
      height: _screenSize.height,
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Text('Sparkle')
      ),
    );
  }
}
