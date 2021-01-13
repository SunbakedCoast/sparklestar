import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sparklestar/SRC/ENTITIES/entities.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';

abstract class ItemRepository {
  Future<List<Item>> loadItem();
  Future<void> add(Item item);
}

class ItemRepo extends ItemRepository {
  final _itemData = FirebaseFirestore.instance.collection('UserItems');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  List<Item> item;
  @override
  Future<List<Item>> loadItem() async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _itemData.doc(_uid).collection('Item').get().then((snapshot) {
      return snapshot.docs
          .map((doc) => Item.fromEntity(ItemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> add(Item item) async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _itemData
        .doc(_uid)
        .collection('Item')
        .add(item.toEntity().toDocument());
  }
}
