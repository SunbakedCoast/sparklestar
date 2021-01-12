import 'package:equatable/equatable.dart';
import 'package:sparklestar/SRC/MODELS/item.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();
  List<Object> get props => [];
}

class LoadAllData extends HomeEvent{}

class DataUpdated extends HomeEvent{
  final List<Item> item;

  const DataUpdated([this.item = const[]]);

  List<Object> get props => [item];
}