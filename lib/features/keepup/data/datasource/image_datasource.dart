import 'package:keep_up/features/keepup/domain/entity/image.dart';

abstract class ImageDataSource{
  ///get the image from local device
  ///throws [SelectionException]
  Future<ImageItem> getSelectedImage();

  ///save the url return from the uploadImage()
  ///throws a [ServerException]
  Future<bool> saveImageUrl(String url);

  ///upload image to data base
  ///throws  [ServerException]
  Future<String> uploadImage(ImageItem imageItem);
}