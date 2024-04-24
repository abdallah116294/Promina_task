import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/Features/gallery/peresentation/cubit/get_gallery_cubit.dart';
import 'package:promina_task/core/cach_helper.dart/cache_helper.dart';
import 'package:promina_task/core/widgts/titles_text_widget.dart';
import 'package:promina_task/injection_container.dart' as di;

class CardListView extends StatefulWidget {
  const CardListView({super.key});

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var token = CacheHelper.getData(key: 'token');
    return BlocProvider(
      create: (context) => di.sl<GetGalleryCubit>()..getGallery(token),
      child: BlocConsumer<GetGalleryCubit, GetGalleryState>(
        listener: (context, state) {
          if (state is GetGallerySuccessState) {
            log(state.gallery.status.toString());
          } else if (state is GetGalleryErrorState) {
            log(state.error.toString());
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocBuilder<GetGalleryCubit, GetGalleryState>(
            builder: (context, state) {
              if (state is GetGalleryLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is GetGallerySuccessState) {
                if (state.gallery.data.images.isEmpty) {
                  return const TitlesTextWidget(
                      label: 'Pleas Upload Image');
                } else {
                  return Container(
                    height: .9*size.height,
                    child: GridView.count(
                      crossAxisCount: 3,
                     //physics: const AlwaysScrollableScrollPhysics(),
                                     shrinkWrap: true,
                                     physics: const BouncingScrollPhysics(),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 1 / 1.88,
                      children: List.generate(
                          state.gallery.data.images.length,
                          (index) => Container(
                                width: 108.w,
                                height: 108.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        state.gallery.data.images[index],fit: BoxFit.cover,)),
                              )
                              ),
                    ),
                  );
                }
              } else if (state is GetGalleryErrorState) {
                return TitlesTextWidget(label: state.error.toString());
              }
              return const CircularProgressIndicator();
            },
          );
        },
      ),
    );
  }
}
