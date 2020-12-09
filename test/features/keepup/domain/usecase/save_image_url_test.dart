import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keep_up/features/keepup/domain/repository/image_repository.dart';
import 'package:keep_up/features/keepup/domain/usecase/save_image_url.dart';
import 'package:mockito/mockito.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main(){
  MockImageRepository mockImageRepository;
  SaveImageUrl useCase;

  setUp((){
    mockImageRepository = MockImageRepository();
    useCase = SaveImageUrl(mockImageRepository);
  });
  
  final tUrl = 'test url';

  test(
    'should return true is url stored',
    ()async{
      when(mockImageRepository.saveImageUrl(any)).thenAnswer((_) async => Right(true));

      final result = await useCase(Params(string: tUrl));

      expect(result, Right(true));

      verify(mockImageRepository.saveImageUrl(tUrl));
      verifyNoMoreInteractions(mockImageRepository);
    });
}