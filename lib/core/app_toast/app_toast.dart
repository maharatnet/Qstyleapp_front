import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/core/app_toast/appIcons.dart';
import 'package:maharat_ecommerce/core/app_toast/styles/text_styles.dart';
import 'package:maharat_ecommerce/core/app_toast/toast_service.dart';

appToast({
  required String message,
  required ToastType type,
  ToastView view = ToastView.top,
  required BuildContext context,
  TextStyle? messageStyle,
  EdgeInsetsGeometry? padding,
  ToastLength length = ToastLength.short
}) => ToastService.showToast(
  context,
  type: type,
  messageStyle: messageStyle ?? TextStyles.textViewBold16,
  length: length,
  expandedHeight: 0,
  topView: view == ToastView.top,
  padding: padding,
  message: message,
  leading: _toastIcon(type: type),
  slideCurve: Curves.elasticInOut,
  positionCurve: Curves.bounceOut,
  dismissDirection: DismissDirection.down,
);

Widget _toastIcon({required ToastType type}) => switch (type) {
  ToastType.success => AppIcons.icon(icon: AppIcons.success, size: 22),
  ToastType.warning => AppIcons.icon(icon: AppIcons.warning, size: 22),
  ToastType.error => AppIcons.icon(icon: AppIcons.error, size: 22),
};

enum ToastView {
  top,
  bottom,
}

enum ToastType {
  success,
  error,
  warning,
}