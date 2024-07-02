import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/model/referral_list.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/extension/string.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets/empty/empty_photo.dart';

class ItemListReferral extends StatelessWidget {
  const ItemListReferral({super.key, required this.referred});

  final Referrer? referred;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: disableColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                referred?.createdAt?.formatDate(format: 'dd MMM yyyy') ?? '',
                textAlign: TextAlign.center,
                style: DDinExp.regular.copyWith(
                  color: gray,
                  fontSize: 12,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: ShapeDecoration(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    style: DDinExp.regular.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: const [
                      WidgetSpan(
                          child: Icon(
                        Icons.check_rounded,
                        size: 14,
                      )),
                      TextSpan(
                        text: " 5 Credits",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: CachedNetworkImage(
                    height: 30,
                    width: 30,
                    imageUrl: referred?.member?.imageUrl ?? '',
                    placeholder: (context, url) => SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        )),
                    errorWidget: (context, url, error) {
                      final firstName =
                          referred?.member?.user?.firstName?.toUpperCase()[0] ??
                              '';
                      final lastName =
                          referred?.member?.user?.lastName?.toUpperCase()[0] ??
                              '';
                      return Center(
                          child: EmptyPhoto(
                        initialName: '$firstName$lastName',
                      ));
                    },
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 10),
              SizedBox(
                child: Text(
                  '${referred?.member?.user?.firstName} ${referred?.member?.user?.lastName}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
