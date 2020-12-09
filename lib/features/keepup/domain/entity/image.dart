import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

//first class
class ImageItem extends Equatable {
  final Uri imageUri;


  ImageItem({@required this.imageUri})
      : super([imageUri]);
}
