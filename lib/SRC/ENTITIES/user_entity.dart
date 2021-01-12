import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UsrEntity extends Equatable{
  final String name;
  final String email;

  UsrEntity(this.name, this.email);

  static UsrEntity fromSnapshot(DocumentSnapshot snapshot){
    return UsrEntity(
      snapshot.data()['name'],
      snapshot.data()['email'],
    );
  }

  Map<String, Object> toDocument(){
    return {
      'name' : name,
      'email' : email
    };
  }

  @override
  List<Object> get props => [name, email]; 
}