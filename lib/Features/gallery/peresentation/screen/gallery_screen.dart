import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_task/Features/gallery/peresentation/cubit/get_gallery_cubit.dart';
import 'package:promina_task/Features/gallery/peresentation/widgets/grid_widget.dart';
import 'package:promina_task/core/cach_helper.dart/cache_helper.dart';
import 'package:promina_task/core/routing/routes.dart';
import 'package:promina_task/core/utils/spacing.dart';
import 'package:promina_task/core/widgts/alert_dailog.dart';
import 'package:promina_task/injection_container.dart' as di;

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  File? _image;
  final picker = ImagePicker();
  Future<void> localImagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    await AppMethods.imagePickerDialog(
        context: context,
        camerFun: () async {
          var pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {
            _image = File(pickedImage!.path);
          });
          var token = CacheHelper.getData(key: 'token');
          BlocProvider.of<GetGalleryCubit>(context)
              .uploadImage(_image!, token)
              .then((value) {
            Navigator.pushNamed(context, Routes.galleryScreen);
          });
          //  di.sl<GetGalleryCubit>().uploadImage(_image!, token);
        },
        galeryFun: () async {
          var pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {
            _image = File(pickedImage!.path);
          });
          var token = CacheHelper.getData(key: 'token');
          BlocProvider.of<GetGalleryCubit>(context)
              .uploadImage(_image!, token)
              .then((value) {
            Navigator.pushNamed(context, Routes.galleryScreen);
          });
          //   di.sl<GetGalleryCubit>().uploadImage(_image!, token);
        },
        removeFun: () {
          setState(() {
            _image = null;
          });
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var token = CacheHelper.getData(key: 'token');
    log(token);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var token = CacheHelper.getData(key: 'token');
    var name = CacheHelper.getData(key: 'name');
    return Scaffold(
        body: BlocProvider(
      create: (context) => di.sl<GetGalleryCubit>(),
      child: BlocConsumer<GetGalleryCubit, GetGalleryState>(
          builder: (context, state) {
        return Stack(
          children: [
            Positioned.fill(child: Image.asset('assets/gellary.png')),
            Positioned(
                top: .05 * size.height,
                left: .1 * size.width,
                child:  Column(
                  children: [
                    Text(
                      "Welcom\n$name",
                      style: TextStyle(color: Color(0xff4A4A4A), fontSize: 32.sp),
                    ),
                  ],
                )),
            Positioned(
              top: .2 * size.height,
              left: .1 * size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 39.85.h,
                    width: 145.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        //Image(image: AssetImage('')),
                        Text('Log out')
                      ],
                    ),
                  ),
                  horizontalSpace(20),
                  InkWell(
                    onTap: () {
                      if (state is UploadImageIsLoading) {
                        Navigator.pushNamed(context, Routes.galleryScreen);
                      } else {
                        localImagePicker(context);
                      }
                      // state is UploadImageIsLoading?Navigator.pushNamed(context,Routes.galleryScreen) :localImagePicker();
                    },
                    child: Container(
                      height: 39.85.h,
                      width: 145.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.upload,
                            color: Colors.yellow,
                          ),
                          //Image(image: AssetImage('')),
                          Text('Upload')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: .25 * size.height,
                left: .1 * size.width,
                right: .1 * size.width,
                child: Container(
                    height: .8 * size.height,
                    child: SingleChildScrollView(child: const CardListView())))
          ],
        );
      }, listener: (context, state) {
        if (state is UploadImageIsLoading) {
          log('loading');
        } else if (state is UploadImageIsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.imageUploadResponse.status.toString())));
          log(state.imageUploadResponse.status);
        }
      }),
    ));
  }
}
