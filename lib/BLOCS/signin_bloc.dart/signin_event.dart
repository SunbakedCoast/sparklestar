import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SigninEvent extends Equatable {
  List<Object> get props => [];
}

class SigninBtnPressed extends SigninEvent{
  final String email;
  final String password;

  SigninBtnPressed({@required this.email, @required this.password});

  List<Object> get props => [email, password];
}