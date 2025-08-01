import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_dialogs_plus/util/dialog_assets.dart';

import 'enums.dart';

class SmartAlertDialog {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    double? titleFontSize,
    double? messageFontSize,
    SmartAlertIconType? iconType,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String confirmText = "OK",
    String cancelText = "Cancel",
    bool showCancel = true,
    bool barrierDismissible = true,
    bool? animateAsset = true,
    bool? loopAnimation = true,
    SmartAlertDialogTheme? alertDialogTheme,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return SmartAlertDialogWidget(
          title: title,
          message: message,
          titleFontSize: titleFontSize,
          messageFontSize: messageFontSize,
          iconType: iconType,
          onConfirm: onConfirm,
          onCancel: onCancel,
          confirmText: confirmText,
          cancelText: cancelText,
          showCancel: showCancel,
          animateAsset: animateAsset ?? true,
          loopAnimation: loopAnimation ?? true,
          alertDialogTheme: alertDialogTheme,
        );
      },
    );
  }
}

/// A theme class for customizing the appearance of the SmartAlertDialog.
class SmartAlertDialogTheme {
  final Color? backgroundColor;
  final Color? titleTextColor;
  final Color? messageTextColor;
  final BorderRadius? buttonsBorderRadius;
  final Color? confirmButtonTextColor;
  final Color? confirmButtonBackgroundColor;
  final Color? cancelButtonTextColor;
  final Color? cancelButtonBackgroundColor;
  final SmartAlertDialogButtonAlignment? buttonAlignment;

  const SmartAlertDialogTheme(
      {this.backgroundColor,
      this.titleTextColor,
      this.messageTextColor,
      this.buttonsBorderRadius,
      this.confirmButtonTextColor,
      this.confirmButtonBackgroundColor,
      this.cancelButtonTextColor,
      this.cancelButtonBackgroundColor,
      this.buttonAlignment});
}

/// A widget that displays a customizable alert dialog with animations.
class SmartAlertDialogWidget extends StatelessWidget {
  final String title;
  final double? titleFontSize;
  final String message;
  final double? messageFontSize;
  final SmartAlertIconType? iconType;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;
  final bool showCancel;
  final Color? color;
  final bool barrierDismissible;
  final bool? animateAsset;
  final bool? loopAnimation;
  final SmartAlertDialogTheme? alertDialogTheme;

  const SmartAlertDialogWidget({
    Key? key,
    required this.title,
    this.titleFontSize = 18.0,
    required this.message,
    this.messageFontSize = 14.0,
    this.iconType,
    this.onConfirm,
    this.onCancel,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.showCancel = true,
    this.color,
    this.barrierDismissible = true,
    this.animateAsset = true,
    this.loopAnimation = true,
    this.alertDialogTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color accent = color ?? _resolveColor(iconType);
    String animationAsset = _resolveAnimation(iconType);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          color: alertDialogTheme?.backgroundColor ?? accent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: animationAsset != "",
                child: Column(
                  children: [
                    Lottie.asset(animationAsset,
                        package: DialogAssets.package,
                        width: 100,
                        height: 100,
                        animate: animateAsset,
                        repeat: loopAnimation),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                      color: alertDialogTheme?.titleTextColor ?? accent)),
              const SizedBox(height: 12),
              Text(message,
                  style: TextStyle(
                      fontSize: messageFontSize,
                      color: alertDialogTheme?.messageTextColor ?? accent),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    _resolveButtonAlignment(alertDialogTheme?.buttonAlignment),
                children: [
                  if (showCancel)
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      alertDialogTheme?.buttonsBorderRadius ??
                                          BorderRadius.circular(8)),
                              backgroundColor: alertDialogTheme
                                      ?.cancelButtonBackgroundColor ??
                                  accent,
                              foregroundColor:
                                  alertDialogTheme?.cancelButtonTextColor ??
                                      Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                            onCancel?.call();
                          },
                          child: Text(
                            cancelText,
                            style: TextStyle(
                                color:
                                    alertDialogTheme?.cancelButtonTextColor ??
                                        Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                alertDialogTheme?.buttonsBorderRadius ??
                                    BorderRadius.circular(8)),
                        backgroundColor:
                            alertDialogTheme?.confirmButtonBackgroundColor ??
                                accent,
                        foregroundColor:
                            alertDialogTheme?.confirmButtonTextColor ??
                                Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm?.call();
                    },
                    child: Text(
                      confirmText,
                      style: TextStyle(
                          color: alertDialogTheme?.confirmButtonTextColor ??
                              Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Resolve alertDialogTheme to MainAxisAlignment.end
  MainAxisAlignment _resolveButtonAlignment(
      SmartAlertDialogButtonAlignment? alignment) {
    switch (alignment) {
      case SmartAlertDialogButtonAlignment.center:
        return MainAxisAlignment.center;
      case SmartAlertDialogButtonAlignment.start:
        return MainAxisAlignment.start;
      default:
        return MainAxisAlignment.end;
    }
  }

  /// Resolve the color based on the icon type.
  Color _resolveColor(SmartAlertIconType? type) {
    switch (type) {
      case SmartAlertIconType.success:
        return Colors.green;
      case SmartAlertIconType.error:
        return Colors.red;
      case SmartAlertIconType.warning:
        return Colors.orange;
      case SmartAlertIconType.info:
        return Colors.blue;
      default:
        return Colors.teal;
    }
  }

  /// Resolve the animation asset based on the icon type.
  String _resolveAnimation(SmartAlertIconType? type) {
    switch (type) {
      case SmartAlertIconType.success:
        return DialogAssets.success;
      case SmartAlertIconType.info:
        return DialogAssets.info;
      case SmartAlertIconType.error:
        return DialogAssets.error;
      case SmartAlertIconType.warning:
        return DialogAssets.warning;
      default:
        return "";
    }
  }
}
