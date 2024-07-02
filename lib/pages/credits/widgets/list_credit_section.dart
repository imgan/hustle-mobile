import 'package:flutter/cupertino.dart';
import 'package:hustle_house_flutter/model/credit.dart';
import 'package:hustle_house_flutter/pages/credits/widgets/item_credit.dart';

class ListCreditSection extends StatelessWidget {
  const ListCreditSection(
      {super.key, required this.onTap, required this.data, this.isExpired});

  final Function(int) onTap;
  final List<Credit> data;
  final bool? isExpired;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemCredit(
            credit: data[index],
            isExpired: isExpired,
            onTap: () {
              onTap(index);
            },
          );
        },
        separatorBuilder: (context, index) {
          if (index == data.length - 1) {
            return const SizedBox(
              height: 20,
            );
          }
          return const SizedBox();
        },
        itemCount: data.length);
  }
}
