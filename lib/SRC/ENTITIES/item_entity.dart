import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String image;
  final String title;
  final int price;
  final String description;
  final String location;

  ItemEntity(
      this.image, this.title, this.price, this.description, this.location);

  static ItemEntity fromSnapshot(DocumentSnapshot snapshot) {
    return ItemEntity(
        snapshot.data()['image'],
        snapshot.data()['title'],
        snapshot.data()['price'],
        snapshot.data()['description'],
        snapshot.data()['location']);
  }

  Map<String, Object> toDocument() {
    return {
      'image': image,
      'title': title,
      'price': price,
      'description': description,
      'location': location
    };
  }

  @override
  List<Object> get props => [image, title, price, description, location];
}
