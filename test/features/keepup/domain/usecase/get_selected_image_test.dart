import 'package:dartz/dartz.dart';
import 'package:keep_up/core/usecase/use_case.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';
import 'package:keep_up/features/keepup/domain/repository/image_repository.dart';
import 'package:keep_up/features/keepup/domain/usecase/get_selected_image.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
//sixth
class MockImageRepository extends Mock implements ImageRepository {}

void main() {
  MockImageRepository mockImageRepository;
  GetSelectedImage useCase;

  setUp(() {
    mockImageRepository = MockImageRepository();
    useCase = GetSelectedImage(mockImageRepository);
  });
  final uri = Uri();
  final selectedImage = ImageItem(imageUri: uri);

  test('should get the uri for the selected Image', () async {
    when(mockImageRepository.getSelectedImage())
        .thenAnswer((_) async => Right(selectedImage));

    final result = await useCase(NoParams());

    expect(result, Right(selectedImage));

    verify(mockImageRepository.getSelectedImage());
    verifyNoMoreInteractions(mockImageRepository);
  });
}
