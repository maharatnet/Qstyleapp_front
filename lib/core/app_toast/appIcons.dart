import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String _path = 'assets/icons/';
  static const String _pathLogo = 'assets/';

  // Icon paths
  static const String success = '${_path}success.svg';
  static const String warning = '${_path}warning.svg';
  static const String error = '${_path}error.svg';
  static const String markerIcon = '${_path}markerIcon.png';
  static const String markerIconTwo = '${_path}markerIcon.svg';
  static Widget icon({required String icon, double? size, Color? color,}) =>  SvgPicture.asset(
    icon,
    width: size??24,
    height: size??24,
    color: color,
    // colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
    // colorFilter: color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
  );
}