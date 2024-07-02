import 'package:flutter/cupertino.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading.dart';

class LoadingCheckout extends StatelessWidget {
  const LoadingCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Loading(
            marginHorizontal: 0,
            height: 92,
          ),
          SizedBox(
            height: 14,
          ),
          Loading(
            marginHorizontal: 0,
            height: 52,
          ),
          SizedBox(
            height: 14,
          ),
          Loading(
            marginHorizontal: 0,
            height: 34,
          ),
          SizedBox(
            height: 14,
          ),
          Loading(
            marginHorizontal: 0,
            height: 200,
          ),
        ],
      ),
    );
  }
}
