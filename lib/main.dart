import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/Features/login/peresentation/cubit/user_login_cubit.dart';
import 'package:promina_task/Features/login/peresentation/screens/login__screen.dart';
import 'package:promina_task/core/cach_helper.dart/cache_helper.dart';
import 'package:promina_task/core/routing/app_routes.dart';
import 'package:promina_task/core/routing/routes.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await CacheHelper.init();
  var token = CacheHelper.getData(key: 'token');
  bool? loginDon = CacheHelper.getData(key: 'LoginDon');
  String? startWidget;
  if (loginDon != null) {
    if (token != null) {
      startWidget = Routes.galleryScreen;
    } else {
      startWidget = Routes.loginScreen;
    }
  } else {
    startWidget = Routes.loginScreen;
  }
  runApp(MyApp(
    appRoutes: AppRoutes(),
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final AppRoutes appRoutes;
  final String startWidget;
  const MyApp({super.key, required this.appRoutes, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => di.sl<UserLoginCubit>())],
        child: ScreenUtilInit(
          designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: appRoutes.onGenerate,
              initialRoute: Routes.loginScreen,
              // home: LoginScreen(),
            );
          },
        ));
  }
}
