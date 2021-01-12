import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent{}

class UserLoggedIn extends AuthenticationEvent{}

class UserLoggedOut extends AuthenticationEvent{}