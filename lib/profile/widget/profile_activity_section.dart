import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/profile/profile_controller.dart';
import 'package:hustle_house_flutter/profile/widget/profile_menu_view.dart';

import '../../model/profile_menu.dart';
import '../../pages/purchaselist/purchase_list_page.dart';
import '../bookinghistory/booking_history_page.dart';
import '../my_vouchers/my_vouchers_page.dart';
import '../purchasehistory/purchase_history_page.dart';
import '../upcomingclass/upcoming_class_page.dart';

class ProfileActivitySection extends StatelessWidget {
  ProfileActivitySection({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      int sumPurchase = controller.totalCreditHistory.value +
          (controller.totalPackageHistory.value);
      int sumVoucher = (controller.totalDiscountVoucher.value) +
          (controller.totalComplimentVoucher.value);
      final List<ProfileMenu> menus = [
        ProfileMenu(
            asset: 'assets/images/ic_book_star.svg',
            text: 'Upcoming Classes',
            number: (controller.upcomingClass.length).toString(),
            onTap: () {
              Get.to(() => const UpcomingClassPage());
            }),
        ProfileMenu(
            asset: 'assets/images/ic_calendar.svg',
            text: 'Booking History',
            number: controller.totalBookingHistory.value.toString(),
            onTap: () {
              Get.to(() => const BookingHistoryPage());
            }),
        ProfileMenu(
            asset: 'assets/images/ic_purchase_history.svg',
            text: 'Purchase History',
            number: sumPurchase.toString(),
            onTap: () {
              Get.to(() => const PurchaseHistoryPage());
            }),
        ProfileMenu(
            asset: 'assets/images/ic_purchase_list.svg',
            text: 'Pending Payment',
            number: controller.totalPurchaseList.value.toString(),
            onTap: () {
              Get.to(() => const PurchaseListPage());
            }),
        ProfileMenu(
            asset: 'assets/images/ic_coupon.svg',
            text: 'My Vouchers',
            number: sumVoucher.toString(),
            onTap: () {
              Get.to(() => MyVouchersPage());
            })
      ];
      return ProfileMenuView(menus: menus, name: 'Activity');
    });
  }
}
