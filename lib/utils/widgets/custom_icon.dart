import 'package:flutter/material.dart';

class CustomIcon {
  CustomIcon._();

  static const String? _kFontPkg = null;

  static const IconData home = IconData(0xe800, fontFamily: 'IconHome', fontPackage: _kFontPkg);
  static const IconData book = IconData(0xe800, fontFamily: 'IconBook', fontPackage: _kFontPkg);
  static const IconData purchase = IconData(0xe800, fontFamily: 'IconPurchase', fontPackage: _kFontPkg);
}