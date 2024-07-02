import 'package:get_storage/get_storage.dart';

class MyPref {
  final isOnBoarding = false.val('onboarding');
  final email  = ''.val('email');
  final accessToken = ''.val('accessToken');
  final appleGivenName = ''.val('appleGivenName');
  final appleFamilyName = ''.val('appleFamilyName');
  final appleEmail = ''.val('appleEmail');
  final myCredit = ''.val('myCredit');
  final recentSearch = [].val('recentSearch');
  final isSubscribe = false.val('isSubscribe');
}
