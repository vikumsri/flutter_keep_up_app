import 'package:flutter/cupertino.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';

class ImageModel extends ImageItem{
    ImageModel({
      @required Uri imageUri
    }) : super(imageUri: imageUri);

    factory ImageModel.fromJson(Map<String, dynamic> json){
      return ImageModel(imageUri: Uri.parse(json['uri']));
    }

    Map<String, dynamic> toJson(){
      return {
        'uri':'image uri'
      };
    }
}