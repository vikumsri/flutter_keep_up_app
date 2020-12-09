import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:keep_up/features/keepup/data/models/image_model.dart';
import 'package:keep_up/features/keepup/domain/entity/image.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final uri = Uri.parse('image uri');
  final tImageModel = ImageModel(imageUri: uri);

  test('should be sub class of ImageItem', () {
    expect(tImageModel, isA<ImageItem>());
  });

  group('fromJson', () {
    test(
        'should return a valid model when the JSON url is a sting and uri is a uri',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('image_url.json'));

      final result = ImageModel.fromJson(jsonMap);

      expect(result, tImageModel);
    });
  });

  group('toJson', () {
    test('should return json map containing proper data', () async {
      final result = tImageModel.toJson();

      final expectedMap = {"uri": "image uri"};

      expect(result, expectedMap);
    });
  });
}
