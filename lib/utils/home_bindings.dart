import 'package:get/get.dart';
import 'package:hustle_house_flutter/pages/book/class/book_class_controller.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class/class_type_controller.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class_schedule/class_schedule_controller.dart';
import 'package:hustle_house_flutter/pages/bookingclass/onemonthpackagelist/package_controller.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/pages/main/main_controller.dart';
import 'package:hustle_house_flutter/pages/register/register_controller.dart';
import 'package:hustle_house_flutter/utils/my_pref.dart';

import 'api/rest_api_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPref());
    Get.lazyPut(() => RestApiController(), fenix: true);
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => BookClassController(), fenix: true);
    Get.lazyPut(() => ClassScheduleController(), fenix: true);
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ClassTypeController(), fenix: true);
    Get.lazyPut(() => PackageController(), fenix: true);
    Get.lazyPut(() => RegisterController(), fenix: true);
  }
}
