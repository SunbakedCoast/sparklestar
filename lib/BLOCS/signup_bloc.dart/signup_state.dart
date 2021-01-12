import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignupState extends Equatable {
  List<Object> get props => [];
}

class SignupInitial extends SignupState{}

class SignupLoading extends SignupState{}

class SignupFailure extends SignupState{
  final String error; 

  SignupFailure({@required this.error});

  List<Object> get props => [error];
}