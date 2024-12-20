import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyResponsiveWidget extends StatelessWidget {
  const MyResponsiveWidget(
      {super.key,
      required this.mobile,
      required this.desktop,
      this.iOS,
      this.macOS,
      this.tablet});

  final Widget mobile;
  final Widget desktop;
  final Widget? tablet;
  final Widget? iOS;
  final Widget? macOS;

  @override
  Widget build(BuildContext context) {
    final orientation = context.orientation;
    final width = context.width;

    if (GetPlatform.isWeb ||
        GetPlatform.isLinux ||
        GetPlatform.isMacOS ||
        GetPlatform.isWindows) {
      if (orientation == Orientation.landscape) {
        return tablet ?? desktop;
      } else {
        if (width <= 850.toDouble()) {
          return mobile;
        } else if (width <= 1100.toDouble()) {
          return tablet ?? desktop;
        } else {
          return desktop;
        }
      }
    } else {
      if (GetPlatform.isAndroid) {
        if (orientation == Orientation.landscape) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      } else if (GetPlatform.isIOS) {
        if (orientation == Orientation.landscape) {
          return macOS ?? tablet ?? iOS ?? desktop;
        } else {
          return iOS ?? mobile;
        }
      } else {
        return mobile;
      }
    }
  }
}
