import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading.dart';

import '../../../../model/trainer.dart';
import '../../../../utils/widgets/empty/empty_photo_rectangle.dart';

class ItemTrainer extends StatelessWidget {
  const ItemTrainer({super.key, required this.onTap, required this.trainer});

  final Trainer trainer;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
          imageUrl: trainer.imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => const Loading(marginHorizontal: 0,),
          errorWidget: (context, url, error) {
            final firstName = trainer.firstName?[0] ?? '';
            final lastName = trainer.lastName?[0] ?? '';
            return Center(
                child: EmptyPhotoRectangle(
              initialName: '$firstName$lastName',
            ));
          },
          imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              )),
    );
  }
}
