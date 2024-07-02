import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hustle_house_flutter/pages/splash/splash_page.dart';
import 'package:hustle_house_flutter/utils/api/env.dart';
import 'package:hustle_house_flutter/utils/home_bindings.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  await GetStorage.init();
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.debug);

  OneSignal.initialize(getOneSignalAppID());

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      fontSizeResolver: FontSizeResolvers.height,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hustle House',
        theme: ThemeData(
          fontFamily: 'D-DIN Exp',
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: false,
        ),
        initialBinding: HomeBindings(),
        home: SplashPage(),
      ),
    );
  }
}
