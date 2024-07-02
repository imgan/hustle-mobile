import 'package:flutter/cupertino.dart';

import 'loading.dart';

class ListLoading extends StatelessWidget {
  const ListLoading(
      {super.key, this.itemCount, this.height, this.marginHorizontal});

  final int? itemCount;
  final double? height;
  final double? marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Loading(
            height: height ?? 72,
            marginHorizontal: marginHorizontal ?? 14,
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 14,
          );
        },
        itemCount: itemCount ?? 5);
  }
}
