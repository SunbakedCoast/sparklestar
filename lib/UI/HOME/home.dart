import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:sparklestar/pages.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sparkle'),
      ),
      floatingActionButton: OpenContainer(
        closedBuilder: (_, openContainer){
          return FloatingActionButton(
            elevation: 8.0,
            onPressed: openContainer,
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.add,
            color: Colors.white),
          );
        },
        openColor: Theme.of(context).accentColor,
        closedElevation: 5.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)),
          closedColor: Theme.of(context).accentColor,
          openBuilder: (_, closeContainer){
            return Add();
          }
      ),
    );
  }
}
