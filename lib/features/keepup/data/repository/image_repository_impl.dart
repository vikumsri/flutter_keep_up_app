import 'package:flutter/cupertino.dart';
import 'package:keep_up/core/error/exception.dart';
import 'package:keep_up/core/network/network_info.dart';
import 'package:keep_up/features/keepup/data/datasource/image_datasource.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';
import 'package:keep_up/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:keep_up/features/keepup/domain/repository/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDataSource dataSource;
  final NetworkInfo networkInfo;

  ImageRepositoryImpl({
    @required this.dataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, ImageItem>> getSelectedImage() async {
    try {
      return Right(await dataSource.getSelectedImage());
    } on SelectionException {
      return Left(SelectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveImageUrl(String url) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await dataSource.saveImageUrl(url));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try{
        throw NetworkException();
      } on NetworkException {
        return Left(NetworkFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(ImageItem imageItem) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await dataSource.uploadImage(imageItem));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        throw NetworkException();
      } on NetworkException {
        return Left(NetworkFailure());
      }
    }
  }
}
