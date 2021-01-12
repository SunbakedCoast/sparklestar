import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';


abstract class SignupEvent extends Equatable {
  List<Object> get props => [];
}

class SignupBtnPressed extends SignupEvent {
  final String email;
  final String password; 

  SignupBtnPressed({@required this.email, @required this.password});

  List<Object> get props => [email, password];
}

class SendUserDataWithButtonPressed extends SignupEvent{
  final Usr user;

  SendUserDataWithButtonPressed({@required this.user});

  List<Object> get props => [user];
  }