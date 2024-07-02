import 'package:flutter/material.dart';

class ProfileMenu {
  final String asset;
  final String text;
  final bool? hasCountLabel;
  final String? number;
  final VoidCallback onTap;
  final Color? color;
  final bool? isDisable;

  ProfileMenu(
      {required this.asset,
      required this.text,
      this.hasCountLabel,
      this.number,
      required this.onTap,
      this.color = Colors.white,
      this.isDisable});
}
