import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemBanner extends StatelessWidget {
  const ItemBanner(
      {super.key, this.image, this.title, this.description, this.onTap});

  final String? image;
  final String? title;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          CachedNetworkImage(
              imageUrl: image ?? '',
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  )),
        ],
      ),
    );
  }
}
