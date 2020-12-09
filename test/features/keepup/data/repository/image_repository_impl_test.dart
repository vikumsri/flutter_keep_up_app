import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_up/core/error/exception.dart';
import 'package:keep_up/core/error/faliures.dart';
import 'package:keep_up/core/network/network_info.dart';
import 'package:keep_up/features/keepup/data/datasource/image_datasource.dart';
import 'package:keep_up/features/keepup/data/models/image_model.dart';
import 'package:keep_up/features/keepup/data/repository/image_repository_impl.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';
import 'package:mockito/mockito.dart';

class MockImageDataSource extends Mock implements ImageDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ImageRepositoryImpl repository;
  MockImageDataSource mockDataSource;
  MockNetworkInfo mockNetworkInfo;
  final tUri = Uri.parse('image uri');
  final tImageModel = ImageModel(imageUri: tUri);
  final ImageItem tImageItem = tImageModel;
  final tUrl = 'image url';

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  setUp(() {
    mockDataSource = MockImageDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ImageRepositoryImpl(
        dataSource: mockDataSource, networkInfo: mockNetworkInfo);
  });

  group('getSelectedImage', () {
    test('should return ImageItem when call to select image is successful',
        () async {
      when(mockDataSource.getSelectedImage())
          .thenAnswer((_) async => tImageModel);

      final result = await repository.getSelectedImage();

      verify(mockDataSource.getSelectedImage());
      expect(result, equals(Right(tImageItem)));
    });

    test(
        'should return Selection Failure when call to select image is unsuccessful',
        () async {
      when(mockDataSource.getSelectedImage()).thenThrow(SelectionException());

      final result = await repository.getSelectedImage();

      verify(mockDataSource.getSelectedImage());

      expect(result, equals(Left(SelectionFailure())));
    });
  });

  group('uploadImage', () {
    
    runTestOnline(() {
      test('should return string after upload is sucessfull', () async {
        when(mockDataSource.uploadImage(any)).thenAnswer((_) async => tUrl);

        final result = await repository.uploadImage(tImageItem);

        verify(mockDataSource.uploadImage(tImageItem));
        //verifyNoMoreInteractions(mockDataSource);
        expect(result, equals(Right(tUrl)));
      });

      test('should return Server failure is the upload is unsucessfull',
          () async {
        when(mockDataSource.uploadImage(any)).thenThrow(ServerException());

        final result = await repository.uploadImage(tImageItem);

        verify(mockDataSource.uploadImage(any));
        verifyNoMoreInteractions(mockDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('should return Network failure when device is offline', () async {
        when(mockDataSource.uploadImage(any)).thenThrow(NetworkException());

        final result = await repository.uploadImage(tImageItem);

        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });

  group('saveImage',(){
    runTestOnline((){
      test('should return true when url is sucessfully saved', () async {
        when(mockDataSource.saveImageUrl(any)).thenAnswer((_) async => true);

        final result = await repository.saveImageUrl(tUrl);

        verify(mockDataSource.saveImageUrl(tUrl));
        expect(result, Right(true));
      });

      test('should return Server failuer if failed to to save url', () async {
        when(mockDataSource.saveImageUrl(any)).thenThrow(ServerException());

        final result = await repository.saveImageUrl(tUrl);

        verify(mockDataSource.saveImageUrl(tUrl));
        expect(result, Left(ServerFailure()));
      });
    });

    runTestOffline((){
      test('should return network failure if no connectivity',()async {
        when(mockDataSource.saveImageUrl(any)).thenThrow(NetworkException());

        final result = await repository.saveImageUrl(tUrl);

        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });
}
