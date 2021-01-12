import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState{}

class AuthenticationLoading extends AuthenticationState{}

class AuthenticationUnAuthenticated extends AuthenticationState{}

class AuthenticationAuthenticated extends AuthenticationState{}

class AuthenticationFailure extends AuthenticationState{
  final String errorMessage;

  AuthenticationFailure({@required this.errorMessage});

  List<Object> get props => [errorMessage];
}