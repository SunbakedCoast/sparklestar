import 'package:equatable/equatable.dart';


abstract class AddState extends Equatable {
  List<Object> get props => [];
}

class AddInitialState extends AddState{}

class AddBtnStateLoading extends AddState{}

class AddBtnStateDone extends AddState{}