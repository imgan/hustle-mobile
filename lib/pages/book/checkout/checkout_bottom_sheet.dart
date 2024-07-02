import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/checkout_book.dart';
import 'package:hustle_house_flutter/pages/book/checkout/checkout_book_controller.dart';
import 'package:hustle_house_flutter/pages/book/checkout/widgets/checkout_header.dart';
import 'package:hustle_house_flutter/pages/book/checkout/widgets/item_checkout_section.dart';
import 'package:hustle_house_flutter/pages/book/checkout/widgets/total_checkout_section.dart';
import 'package:hustle_house_flutter/pages/book/checkout/widgets/voucher_checkout_section.dart';
import 'package:hustle_house_flutter/utils/device_type.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';
import 'package:hustle_house_flutter/utils/widgets/card/custom_card.dart';
import 'package:hustle_house_flutter/utils/widgets/primary_button.dart';

import '../../../utils/colors.dart';

class CheckoutBottomSheet extends StatelessWidget {
  CheckoutBottomSheet(
      {super.key,
      this.isClass,
      this.checkOutBook,
      this.onTap,
      this.route,
      this.category,
      this.locationID});

  final bool? isClass;
  final CheckOutBook? checkOutBook;
  final VoidCallback? onTap;
  final String? route;
  final String? category;
  final int? locationID;
  final CheckoutBookController controller = Get.put(CheckoutBookController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutBookController>(builder: (context) {
      var checkOutBook = controller.checkOutBook.value;
      return CustomCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (getDeviceType() == MyDeviceType.tablet)
              SizedBox(
                height: 10.h,
              ),
            const CheckoutHeader(),
            if (getDeviceType() == MyDeviceType.tablet)
              SizedBox(
                height: 10.h,
              ),
            Divider(thickness: 10.h, color: gray1),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'My Credit: ${checkOutBook?.credit}',
                textAlign: TextAlign.center,
                style: DDinExp.bold.copyWith(
                  color: Colors.black,
                  fontSize: 16.h,
                ),
              ),
            ),
            Divider(thickness: 1.h, color: gray1),
            ItemCheckoutSection(
                isClass: isClass ?? false,
                imageUrl: checkOutBook?.image ?? '',
                name: checkOutBook?.name ?? '',
                hour: checkOutBook?.hour ?? '',
                date: checkOutBook?.date ?? '',
                trainer: checkOutBook?.trainer ?? '',
                location: checkOutBook?.location ?? '',
                total: checkOutBook?.total ?? ''),
            VoucherCheckoutSection(
              route: route ?? '',
              voucher: checkOutBook?.voucher ?? '',
              category: category ?? '',
              locationID: locationID,
            ),
            TotalCheckoutSection(total: checkOutBook?.total ?? ''),
            PrimaryButton(
              borderRadiusSize: 0,
              elevation: 0,
              text: 'Book Now',
              onPressed: onTap,
            ),
          ],
        ),
      );
    });
  }
}
