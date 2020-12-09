import 'package:dartz/dartz.dart';
import 'package:keep_up/core/error/faliures.dart';
import 'package:keep_up/core/usecase/use_case.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';
import 'package:keep_up/features/keepup/domain/repository/image_repository.dart';
//seventh
//Select a image to upload from the phone
class GetSelectedImage implements UseCase<ImageItem, NoParams>{
  final ImageRepository repository;

GetSelectedImage(this.repository);

@override
Future<Either<Failure, ImageItem>> call(NoParams params) async {
    return await repository.getSelectedImage();
  }
}

