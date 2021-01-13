
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sparklestar/SRC/ENTITIES/entities.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';

abstract class UsrRepository {
  //Future<void> sendUserData(Usr user);
  Future<Usr> getUserDatafromDatabase();
}

class FireStoreUsrRepo extends UsrRepository{
  final _usrData = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /* @override
  Future<void> sendUserData(Usr user) {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid; 
    return _usrData.doc(_uid).set(user.toEntity().toDocument());
  } */

   @override
  Future<Usr> getUserDatafromDatabase() {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _usrData.doc(_uid).get().then((snapshot){
      return Usr.fromEntity(UsrEntity.fromSnapshot(snapshot));
    });
  } 
}