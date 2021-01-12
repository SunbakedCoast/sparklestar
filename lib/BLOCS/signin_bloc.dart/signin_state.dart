import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SigninState extends Equatable{
  List<Object> get props => [];
}

class SigninInitial extends SigninState{}

class SigninLoading extends SigninState{}

class SigninSuccess extends SigninState{}

class SigninFailure extends SigninState{
  final String error;

  SigninFailure({@required this.error});

  List<Object> get props => [error];
}
