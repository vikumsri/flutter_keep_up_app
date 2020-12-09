import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:keep_up/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:keep_up/core/usecase/use_case.dart';
import 'package:keep_up/features/keepup/domain/repository/image_repository.dart';
import 'package:keep_up/features/keepup/domain/usecase/upload_image.dart';

//after saving image to database save the image url 
class SaveImageUrl implements UseCase<bool, Params>{
  final ImageRepository repository;

  SaveImageUrl(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.saveImageUrl(params.string);
  }
  
}

class Params extends Equatable {
  final String string;

  Params({@required this.string}) : super([string]);
}
