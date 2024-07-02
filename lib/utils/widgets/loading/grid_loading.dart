import 'package:flutter/cupertino.dart';

import 'loading.dart';

class GridLoading extends StatelessWidget {
  const GridLoading({super.key, this.childAspectRatio, this.itemCount});

  final double? childAspectRatio;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: childAspectRatio ?? 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: itemCount ?? 9,
      itemBuilder: (context, index) {
        return const Loading(
          marginHorizontal: 0,
        );
      },
    );
  }
}
