import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sparklestar/SRC/ENTITIES/item_entity.dart';

class Item extends Equatable {
  final String image;
  final String title;
  final int price;
  final String description;
  final String location;

  Item(
      {@required this.image,
      @required this.title,
      @required this.price,
      @required this.description,
      @required this.location});

  static Item fromEntity(ItemEntity entity) {
    return Item(
        image: entity.image,
        title: entity.title,
        price: entity.price,
        description: entity.description,
        location: entity.location);
  }

  Map<String, dynamic> toMap() => {
    'image' : image, 
    'title' : title, 
    'price' : price, 
    'description' : description, 
    'location': location
  };

  ItemEntity toEntity() {
    return ItemEntity(image, title, price, description, location);
  }

  @override
  List<Object> get props => [image, title, price, description, location];
}
