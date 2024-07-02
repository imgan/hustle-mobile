import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading.dart';
import 'package:hustle_house_flutter/utils/widgets/text/text_title.dart';

import '../../../../utils/colors.dart';

class ItemListClass extends StatelessWidget {
  final SportClass sportClass;
  final VoidCallback? onTap;

  const ItemListClass({super.key, required this.sportClass, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.zero,
              shadowColor: disableColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                              height: 50,
                              width: 50,
                              imageUrl: sportClass.sportsClassAsset?.logoUrl ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Loading(
                                marginHorizontal: 0,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                        child: TextTitle(text: sportClass.name ?? '')),
                    const Spacer(),
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: disableColor
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
