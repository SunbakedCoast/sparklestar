import 'package:equatable/equatable.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';
import 'package:meta/meta.dart';

abstract class AddEvent extends Equatable {
  List<Object> get props => [];
}

class AddBtnPressed extends AddEvent{
  final Item item; 
  
  AddBtnPressed({@required this.item});

  List<Object> get props => [item];
}

