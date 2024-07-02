import 'package:flutter/material.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class/widget/class_section.dart';
import 'package:hustle_house_flutter/pages/bookingclass/class/widget/monthly_package_section.dart';
import 'package:hustle_house_flutter/utils/widgets/custom_app_bar.dart';

import '../../../utils/colors.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Classes',
        isNoLeading: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const MonthlyPackageSection(),
              const SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
                indent: 0,
                color: gray1,
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              const ClassSection(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
