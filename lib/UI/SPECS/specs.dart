import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Specifications extends StatelessWidget{
  String title; 
  String price; 
  String description;
  String location;

  Specifications({@required this.title, 
  @required this.price, 
  @required this.description,
  @required this.location});

  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title),
            Text(price),
            Text(description),
            Text(location),
          ],
        ),
      ),
    );
  }
}