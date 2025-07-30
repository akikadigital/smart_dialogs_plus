import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_dialogs_plus/util/dialog_assets.dart';

import 'enums.dart';

class SmartAlertDialog {
  static void show(
    BuildContext context, {
    required String title,
    double? titleFontSize,
    required String message,
    double? messageFontSize,
    SmartAlertType type = SmartAlertType.info,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String confirmText = "OK",
    String cancelText = "Cancel",
    bool showCancel = true,
    Color? color,
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
          titleFontSize: titleFontSize,
          message: message,
          messageFontSize: messageFontSize,
          type: type,
          onConfirm: onConfirm,
          onCancel: onCancel,
          confirmText: confirmText,
          cancelText: cancelText,
          showCancel: showCancel,
          color: color,
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

  const SmartAlertDialogTheme(
      {this.backgroundColor,
      this.titleTextColor,
      this.messageTextColor,
      this.buttonsBorderRadius,
      this.confirmButtonTextColor,
      this.confirmButtonBackgroundColor,
      this.cancelButtonTextColor,
      this.cancelButtonBackgroundColor});
}

/// A widget that displays a customizable alert dialog with animations.
class SmartAlertDialogWidget extends StatelessWidget {
  final String title;
  final double? titleFontSize;
  final String message;
  final double? messageFontSize;
  final SmartAlertType type;
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
    this.type = SmartAlertType.info,
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
    Color accent = color ?? _resolveColor(type);
    String animationAsset = _resolveAnimation(type);

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
              Lottie.asset(animationAsset,
                  package: DialogAssets.package,
                  width: 100,
                  height: 100,
                  animate: animateAsset,
                  repeat: loopAnimation),
              const SizedBox(height: 8),
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
                mainAxisAlignment: MainAxisAlignment.end,
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

  Color _resolveColor(SmartAlertType type) {
    switch (type) {
      case SmartAlertType.success:
        return Colors.green;
      case SmartAlertType.error:
        return Colors.red;
      case SmartAlertType.warning:
        return Colors.orange;
      case SmartAlertType.info:
        return Colors.blue;
      default:
        return Colors.teal;
    }
  }

  String _resolveAnimation(SmartAlertType type) {
    switch (type) {
      case SmartAlertType.success:
        return DialogAssets.success;
      case SmartAlertType.error:
        return DialogAssets.error;
      case SmartAlertType.warning:
        return DialogAssets.warning;
      default:
        return DialogAssets.info;
    }
  }
}
