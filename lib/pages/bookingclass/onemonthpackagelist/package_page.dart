import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/pages/bookingclass/onemonthpackagelist/widget/package_section.dart';

import '../../../utils/widgets/custom_app_bar.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Package',
      ),
      backgroundColor: Colors.white,
      body: PackageSection(),
    );
  }
}
