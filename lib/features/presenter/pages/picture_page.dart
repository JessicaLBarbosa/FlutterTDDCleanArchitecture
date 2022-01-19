// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:clean_arch_tdd/features/domain/entities/space_media_entity.dart';
import 'package:clean_arch_tdd/features/presenter/controllers/home_store.dart';
import 'package:clean_arch_tdd/features/presenter/widgets/description_bottom_sheet.dart';
import 'package:clean_arch_tdd/features/presenter/widgets/image_network_with_loader.dart';
import 'package:clean_arch_tdd/features/presenter/widgets/page_slider_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class PicturePage extends StatefulWidget {
  late final DateTime? dateSelected;

  PicturePage({
    Key? key,
    this.dateSelected,
  }) : super(key: key);

  PicturePage.fromArgs(dynamic arguments, {Key? key}) : super(key: key) {
    dateSelected = arguments['dateSelected'];
  }

  static void navigate(DateTime? dateSelected) {
    Modular.to.pushNamed(
      '/picture',
      arguments: {'dateSelected': dateSelected},
    );
  }

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaFromDate(widget.dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScopedBuilder(
        store: store,
        onLoading: (context) => Center(child: CircularProgressIndicator()),
        onError: (context, error) => Center(
          child: Text(
            'An error occurred, try again later.',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.white),
          ),
        ),
        onState: (context, SpaceMediaEntity spaceMedia) {
          return PageSliderUp(
            onSlideUp: () => showDescriptionBottomSheet(
              context: context,
              title: spaceMedia.title,
              description: spaceMedia.description,
            ),
            child: spaceMedia.mediaType == 'video'
                ? CustomVideoPlayer(spaceMedia)
                : spaceMedia.mediaType == 'image'
                    ? ImageNetworkWithLoader(spaceMedia.mediaUrl)
                    : Container(),
          );
        },
      ),
    );
  }
}
