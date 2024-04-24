import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:promina_task/Features/gallery/data/repo/get_gallery_repo.dart';
import 'package:promina_task/Features/gallery/data/repo/get_gallery_repo_impl.dart';
import 'package:promina_task/Features/gallery/data/repo/upload_image_impl.dart';
import 'package:promina_task/Features/gallery/data/repo/upload_image_repo.dart';
import 'package:promina_task/Features/gallery/peresentation/cubit/get_gallery_cubit.dart';
import 'package:promina_task/Features/login/data/repo/login_repo.dart';
import 'package:promina_task/Features/login/data/repo/login_repo_impl.dart';
import 'package:promina_task/Features/login/peresentation/cubit/user_login_cubit.dart';
import 'package:promina_task/core/network/api_consumer.dart';
import 'package:promina_task/core/network/api_interceptors.dart';
import 'package:promina_task/core/network/dio_consumer.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Login
  //cubit
  sl.registerFactory<UserLoginCubit>(() => UserLoginCubit(loginRepo: sl()));
  //repo
  sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(apiConsumer: sl()));
  //gallery
  sl.registerFactory<GetGalleryCubit>(
      () => GetGalleryCubit(repo: sl(), uploadImageRepo: sl()));
  //repo
  sl.registerLazySingleton<GetMyGalleryRepo>(
      () => GetGalleryRepoImpl(apiConsumer: sl()));
  sl.registerLazySingleton<UploadImageRepo>(() => UploadImageRepoImpl(apiConsumer: sl()));
  //core
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => Dio());
}
