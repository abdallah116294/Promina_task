import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/Features/gallery/data/models/image_upload_successfull_model.dart';
import 'package:promina_task/Features/gallery/data/models/success_gallery.dart';
import 'package:promina_task/Features/gallery/data/repo/get_gallery_repo.dart';
import 'package:promina_task/Features/gallery/data/repo/upload_image_repo.dart';

part 'get_gallery_state.dart';

class GetGalleryCubit extends Cubit<GetGalleryState> {
  GetGalleryCubit({required this.repo, required this.uploadImageRepo})
      : super(GetGalleryInitial());
  GetMyGalleryRepo repo;
  UploadImageRepo uploadImageRepo;
  Future<void> getGallery(String token) async {
    emit(GetGalleryLoadingState());
    try {
      final gallery = await repo.getGallery(token);
      emit(GetGallerySuccessState(gallery: gallery));
    } catch (eror) {
      emit(GetGalleryErrorState(error: eror.toString()));
    }
  }

  Future<void> uploadImage(File img, String token) async {
    emit(UploadImageIsLoading());
    try {
      final response = await uploadImageRepo.uploadImage(img, token);
      emit(UploadImageIsSuccess(imageUploadResponse: response));
    } catch (error) {
      emit(UploadImageIsError(error: error.toString()));
    }
  }
}
