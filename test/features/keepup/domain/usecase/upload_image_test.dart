import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';
import 'package:keep_up/features/keepup/domain/repository/image_repository.dart';
import 'package:keep_up/features/keepup/domain/usecase/upload_image.dart';
import 'package:mockito/mockito.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main(){
  MockImageRepository mockImageRepository;
  UploadImage useCase;

  setUp((){
    mockImageRepository = MockImageRepository();
    useCase = UploadImage(mockImageRepository);
  });

  final tUrl = 'www.imageurl.com/image1';
  final tUri = Uri.parse('image uri');
  final selectedImage = ImageItem(imageUri: tUri);
  test(
    'should return string after sucessfully uploading',
    ()async{
      when(mockImageRepository.uploadImage(any))
      .thenAnswer((_) async => Right(tUrl));

    final result = await useCase(Params(imageItem: selectedImage));

    expect(result, Right(tUrl));
    verify(mockImageRepository.uploadImage(selectedImage));
    verifyNoMoreInteractions(mockImageRepository);
    });
}