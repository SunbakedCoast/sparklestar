import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sparklestar/SRC/ENTITIES/user_entity.dart';

class Usr extends Equatable{
  final String name; 
  final String email; 

  Usr({@required this.name, @required this.email});

  static Usr fromEntity(UsrEntity entity){
    return Usr(name: entity.name,
    email: entity.email);
  }

  UsrEntity toEntity(){
    return UsrEntity(name, email);
  }

  @override
  // TODO: implement props
  List<Object> get props => [name, email];

}