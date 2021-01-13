import 'dart:io';

import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparklestar/BLOCS/home_bloc/home.dart';
import 'package:sparklestar/SRC/MODELS/item.dart';
import 'package:flutter/material.dart';
import 'package:sparklestar/pages.dart';

// ignore: must_be_immutable
class Gridview extends StatelessWidget {
  final DataLoaded state;
  List<Item> items;

  Gridview({@required this.state, @required this.items});

  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    items = state.item;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: GridView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, int index) => _item(
                  context: context,
                  size: _screenSize,
                  image: items[index].image,
                  title: items[index].title,
                  price: items[index].price,
                  description: items[index].description,
                  location: items[index].location)),
        )
      ],
    );
  }

  ///TODO [FIX]
  Widget _item(
      {BuildContext context,
      Size size,
      String image,
      String title,
      int price,
      String description,
      String location}) {
    return Container(
      padding: const EdgeInsets.all(3),
      child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image.toString()))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: size.width,
                    height: 40,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text('\$${price.toString()}',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          closedElevation: 5,
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          openBuilder: (_, closeContainer) {
            return Specifications(
              title: title,
              price: price.toString(),
              description: description,
              location: location,
            );
          }),
    );
  }
}

/* 
return Container(
      padding: const EdgeInsets.all(3),
      child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: size.width * 0.9,
                    height: 100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black])),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 5),
                          width: 3,
                          height: 20,
                          color: Theme.of(context).accentColor,
                        ),
                        Text('\$${price.toString()}',
                            style: Theme.of(context).textTheme.headline4)
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          closedElevation: 5,
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          openBuilder: (_, closeContainer) {
           ///TODO[RETURN]
          }),
    ); */
