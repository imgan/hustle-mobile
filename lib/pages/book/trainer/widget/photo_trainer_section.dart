import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:hustle_house_flutter/model/trainer.dart';

import '../../../../utils/widgets/empty/empty_photo.dart';
import '../../../../utils/widgets/loading/loading.dart';

class PhotoTrainerSection extends StatelessWidget {
  const PhotoTrainerSection({super.key, required this.trainer});

  final Trainer? trainer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: CachedNetworkImage(
            height: 120,
            width: 120,
            imageUrl: trainer?.imageUrl ?? '',
            placeholder: (context, url) => const Loading(
              marginHorizontal: 0,
            ),
            errorWidget: (context, url, error) {
              final firstName = trainer?.firstName?[0] ?? '';
              final lastName = trainer?.lastName?[0] ?? '';
              return Center(
                  child: EmptyPhoto(
                initialName: '$firstName$lastName',
                sizePhoto: 120,
                sizeFont: 20,
              ));
            },
            fit: BoxFit.cover,
          )),
    );
  }
}
