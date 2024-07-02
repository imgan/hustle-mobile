import 'package:flutter/cupertino.dart';

enum MyDeviceType { phone, tablet }

MyDeviceType getDeviceType() {
  final data = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);
  return data.size.shortestSide < 550 ? MyDeviceType.phone : MyDeviceType.tablet;
}
