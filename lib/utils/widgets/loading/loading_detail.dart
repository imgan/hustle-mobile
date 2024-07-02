import 'package:flutter/cupertino.dart';
import 'package:hustle_house_flutter/utils/widgets/loading/loading.dart';

class LoadingDetail extends StatelessWidget {
  const LoadingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Loading(
            marginHorizontal: 0,
            height: 214,
          ),
          const SizedBox(
            height: 14,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Loading(
                height: 30,
              )),
              Expanded(
                  child: Loading(
                height: 30,
              )),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Loading(
            height: 15,
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 14,
          ),
          Loading(
            height: 15,
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 14,
          ),
          Loading(
            height: 15,
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 14,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Loading(
                  height: 150,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 14,
                );
              },
              itemCount: 3)
        ],
      ),
    );
  }
}
