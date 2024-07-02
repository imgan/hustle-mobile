import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hustle_house_flutter/utils/typography/d_din_exp.dart';

import '../../colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
      required this.length,
      required this.tabs,
      required this.pages,
      this.isScrollable,
      this.onTap,
      this.tabController,
      this.scrollPhysics,
      this.showBottomDivider});

  final int length;
  final List<Widget> tabs;
  final List<Widget> pages;
  final bool? isScrollable;
  final Function(int)? onTap;
  final TabController? tabController;
  final ScrollPhysics? scrollPhysics;
  final bool? showBottomDivider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: DefaultTabController(
          initialIndex: 0,
          length: length,
          child: SafeArea(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (showBottomDivider ?? false)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: disableColor, width: 1),
                      )),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    child: TabBar(
                        controller: tabController,
                        dividerColor: Colors.transparent,
                        isScrollable: isScrollable ?? false,
                        indicatorColor: Colors.black,
                        padding: EdgeInsets.zero,
                        indicatorPadding:
                            EdgeInsets.all((isScrollable ?? false) ? 0 : -5),
                        labelPadding:
                            (isScrollable ?? false) ? null : EdgeInsets.zero,
                        labelStyle: DDinExp.bold.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelStyle: DDinExp.bold.copyWith(
                          color: gray,
                          fontSize: 14.sp,
                        ),
                        unselectedLabelColor: gray2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        onTap: onTap,
                        tabs: tabs),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics:
                      scrollPhysics ?? const NeverScrollableScrollPhysics(),
                  children: pages,
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
