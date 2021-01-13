import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sparklestar/SRC/ENTITIES/entities.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

abstract class ItemRepository {
  Future<List<Item>> loadItem();
  Future<void> addtoFirestore(Item item, File image);
  Future<String> uploadPic(File image);
}

class ItemRepo extends ItemRepository {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
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

/*
  @override
  Future<void> addtoFirestore(Item item) async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _itemData
        .doc(_uid)
        .collection('Item')
        .add(item.toEntity().toDocument());
  } */

  @override
  Future<void> addtoFirestore(Item item, File image) async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    /*String dlUrl;
    var uuid = Uuid();
    try {
      await _firebaseStorage
          .ref('images/$_uid/${uuid.v4()}')
          .putFile(image)
          .then((value) async {
        dlUrl = await _firebaseStorage
            .ref('images/$_uid/${uuid.v4()}')
            .getDownloadURL();
      });
    } catch (e) {} */
    return _itemData
        .doc(_uid)
        .collection('Item')
        .add(item.toEntity().toDocument());
        
  }

  @override
  Future<String> uploadPic(File image) async {
    String dlUrl;
    var uuid = Uuid();
    try {
      await _firebaseStorage
          .ref('images/${uuid.v4()}')
          .putFile(image)
          .then((value) async {
        dlUrl =
            await _firebaseStorage.ref('images/${uuid.v4()}').getDownloadURL();
      });
    } catch (e) {}
    return dlUrl;
  }

  /*@override
  Future<String> uploadPic(File image) async {
    Reference ref = FirebaseStorage.instance.ref('test').child(image.toString());
    UploadTask uploadTask = ref.putFile(image);
    return uploadTask.then((res){
      //print('DLURL: ${res.ref.getDownloadURL()}');
      return res.ref.getDownloadURL();
    });
  } */
}
