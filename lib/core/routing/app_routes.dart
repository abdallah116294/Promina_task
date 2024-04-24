import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/Features/gallery/peresentation/cubit/get_gallery_cubit.dart';
import 'package:promina_task/Features/gallery/peresentation/screen/gallery_screen.dart';
import 'package:promina_task/Features/login/peresentation/cubit/user_login_cubit.dart';
import 'package:promina_task/Features/login/peresentation/screens/login__screen.dart';
import 'package:promina_task/core/routing/routes.dart';
import 'package:promina_task/injection_container.dart' as di;

class AppRoutes {
  Route? onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (_) => di.sl<UserLoginCubit>(),
                  child: const LoginScreen(),
                ));
      case Routes.galleryScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (_) => di.sl<GetGalleryCubit>(),
                  child: const GalleryScreen(),
                ));
    }
    return null;
  }
}
