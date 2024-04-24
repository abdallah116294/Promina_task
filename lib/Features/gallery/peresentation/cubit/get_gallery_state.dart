part of 'get_gallery_cubit.dart';

sealed class GetGalleryState extends Equatable {
  const GetGalleryState();

  @override
  List<Object> get props => [];
}

final class GetGalleryInitial extends GetGalleryState {}

class GetGallerySuccessState extends GetGalleryState {
  GalleryResponse gallery;
  GetGallerySuccessState({required this.gallery});
}

class GetGalleryErrorState extends GetGalleryState {
  final String error;
  GetGalleryErrorState({required this.error});
}

class GetGalleryLoadingState extends GetGalleryState {}

class UploadImageIsLoading extends GetGalleryState {}

class UploadImageIsSuccess extends GetGalleryState {
  final ImageUploadResponse imageUploadResponse;
  UploadImageIsSuccess({required this.imageUploadResponse});
}

class UploadImageIsError extends GetGalleryState {
  final String error;
  UploadImageIsError({required this.error});
}
