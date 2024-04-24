import 'dart:io';

import 'package:promina_task/Features/gallery/data/models/image_upload_successfull_model.dart';

abstract class UploadImageRepo {
  Future<ImageUploadResponse> uploadImage(File img,String token);
}
