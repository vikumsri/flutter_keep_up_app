import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:keep_up/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:keep_up/core/usecase/use_case.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';
import 'package:keep_up/features/keepup/domain/repository/image_repository.dart';

//upload the selected image
class UploadImage implements UseCase<String, Params> {
  final ImageRepository repository;

  UploadImage(this.repository);

  @override
  Future<Either<Failure, String>> call(Params params) async {
    return await repository.uploadImage(params.imageItem);
  }
}

class Params extends Equatable {
  final ImageItem imageItem;

  Params({@required this.imageItem}) : super([imageItem]);
}
