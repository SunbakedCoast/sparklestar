import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:sparklestar/SRC/MODELS/models.dart';
import 'package:meta/meta.dart';

abstract class AddEvent extends Equatable {
  List<Object> get props => [];
}

class AddBtnPressed extends AddEvent{
  final Item item; 
  final File image; 
  
  AddBtnPressed({@required this.item, @required this.image});

  List<Object> get props => [item, image];
}

class UploadImageOnBtnPressed extends AddEvent{
  final File image; 

  UploadImageOnBtnPressed({@required this.image});

  List<Object> get props => [image];
}

