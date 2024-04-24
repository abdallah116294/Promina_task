import 'dart:io';

import 'package:dio/dio.dart';
import 'package:promina_task/Features/gallery/data/models/image_upload_successfull_model.dart';
import 'package:promina_task/Features/gallery/data/repo/upload_image_repo.dart';
import 'package:promina_task/core/network/api_constant.dart';
import 'package:promina_task/core/network/api_consumer.dart';

class UploadImageRepoImpl implements UploadImageRepo {
  ApiConsumer apiConsumer;
  UploadImageRepoImpl({required this.apiConsumer});
  @override
  Future<ImageUploadResponse> uploadImage(File img, String token) async {
    try {
      final reponse = await apiConsumer.postFile(ApiConstant.uploadImage,
          isFormData: true, formData: {"img": await convetImage(img)}, token: token);
      final image = ImageUploadResponse.fromJson(reponse);
      return image;
    } catch (error) {
      throw error;
    }
  }

  Future convetImage(File image) async {
    return MultipartFile.fromFile(image.path,
        filename: image.path.split('/').last);
  }
}
