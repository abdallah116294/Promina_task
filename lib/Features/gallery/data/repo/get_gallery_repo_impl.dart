import 'dart:developer';

import 'package:promina_task/Features/gallery/data/models/success_gallery.dart';
import 'package:promina_task/Features/gallery/data/repo/get_gallery_repo.dart';
import 'package:promina_task/core/network/api_constant.dart';
import 'package:promina_task/core/network/api_consumer.dart';

class GetGalleryRepoImpl implements GetMyGalleryRepo {
  ApiConsumer apiConsumer;
  GetGalleryRepoImpl({required this.apiConsumer});
  @override
  Future<GalleryResponse> getGallery(String tolken) async {
    try {
      final response =
          await apiConsumer.get(ApiConstant.getImages, token: tolken);
      log(response.toString());
      final gallery = GalleryResponse.fromJson(response);
      return gallery;
    } catch (error) {
      throw error;
    }
  }
}
