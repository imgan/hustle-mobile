import 'package:flutter/cupertino.dart';

import '../../../utils/widgets/loading/loading.dart';

class LoadingReview extends StatelessWidget {
  const LoadingReview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Loading(
            height: 115,
            marginHorizontal: 0,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Loading(
                  height: 95,
                  marginHorizontal: 0,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: 7),
        ],
      ),
    );
  }
}
