import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/recovery.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../../../utils/widgets/loading/loading.dart';

class ItemRecovery extends StatelessWidget {
  const ItemRecovery({
    super.key,
    required this.onTap,
    this.recovery,
  });

  final VoidCallback onTap;
  final Recovery? recovery;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 10,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CachedNetworkImage(
                  imageUrl: recovery?.assets?.logoUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Loading(
                        marginHorizontal: 0,
                      ),
                  errorWidget: (context, url, error) => const Center(
                          child: Icon(
                        Icons.error,
                        size: 72,
                      ))),
            ),
            const SizedBox(height: 9),
            Text(
              recovery?.name ?? '',
              textAlign: TextAlign.center,
              style: DDinExp.bold.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
