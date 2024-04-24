// import 'package:promina_task/Features/gallery/data/models/data_model.dart';

// class SuccessGallery{
//  final   String status;
//  final DataModel data;
//  final String message;

//   SuccessGallery({required this.status, required this.data, required this.message});
//  factory SuccessGallery.fromJson(Map<String,dynamic>json){
//   return SuccessGallery(data: DataModel.fromJson(json['data']),message: json['message'],status: json["status"]);
//  }
// }
class GalleryResponse {
  final String status;
  final GalleryData data;
  final String message;

  GalleryResponse({
    required this.status,
    required this.data,
    required this.message,
  });

  factory GalleryResponse.fromJson(Map<String, dynamic> json) {
    return GalleryResponse(
      status: json['status'],
      data: GalleryData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class GalleryData {
  final List<String> images;

  GalleryData({
    required this.images,
  });

  factory GalleryData.fromJson(Map<String, dynamic> json) {
    return GalleryData(
      images: List<String>.from(json['images'].map((x) => x)),
    );
  }
}
