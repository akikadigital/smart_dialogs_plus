import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        );
      },
    );
  }
}

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color accent = color ?? _resolveColor(type);
    String animationAsset = _resolveAnimation(type);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(animationAsset,
                width: 100,
                height: 100,
                animate: animateAsset,
                repeat: loopAnimation),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                    color: accent)),
            const SizedBox(height: 12),
            Text(message,
                style: TextStyle(fontSize: messageFontSize),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showCancel)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    child: Text(cancelText),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: accent),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm?.call();
                  },
                  child: Text(confirmText),
                )
              ],
            )
          ],
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
        return 'assets/success.json';
      case SmartAlertType.error:
        return 'assets/error.json';
      case SmartAlertType.warning:
        return 'assets/warning.json';
      case SmartAlertType.info:
        return 'assets/info_alert.json';
      default:
        return 'assets/info_alert.json';
    }
  }
}
