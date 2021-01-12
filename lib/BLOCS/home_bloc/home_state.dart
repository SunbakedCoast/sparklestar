
import 'package:sparklestar/SRC/MODELS/item.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable{
  const HomeState();
  List<Object> get props => [];
}

class HomeInitial extends HomeState{}

class HomeLoading extends HomeState{}

class DataLoaded extends HomeState{
  final List<Item> item; 

  const DataLoaded([this.item = const[]]);

  List<Object> get props => [item]; 
}

class FetchError extends HomeState{
  final String error; 

  const FetchError({@required this.error});
  List<Object> get props => [error];
}