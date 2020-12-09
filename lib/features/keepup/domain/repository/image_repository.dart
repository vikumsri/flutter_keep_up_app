import 'package:dartz/dartz.dart';
import 'package:keep_up/core/error/faliures.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';
//third
abstract class ImageRepository{
  Future<Either<Failure, ImageItem>> getSelectedImage();
  Future<Either<Failure, bool>> saveImageUrl(String url);
  Future<Either<Failure, String>> uploadImage(ImageItem imageItem);
}