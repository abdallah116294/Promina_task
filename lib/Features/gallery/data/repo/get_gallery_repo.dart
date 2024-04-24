import 'package:promina_task/Features/gallery/data/models/success_gallery.dart';

abstract class GetMyGalleryRepo {
  Future<GalleryResponse> getGallery(String tolken);
}
