import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'dialog_state.dart';

class SmartAlertDialog extends StatelessWidget {
  final String title;
  final double? titleFontSize;
  final String message;
  final double? messageFontSize;
  final SmartProgressState state;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;
  final bool showCancel;
  final Color? color;
  final bool barrierDismissible;
  final bool? animateAsset;
  final bool? loopAnimation;

  const SmartAlertDialog({
    Key? key,
    required this.title,
    this.titleFontSize = 18.0,
    required this.message,
    this.messageFontSize = 14.0,
    this.state = SmartProgressState.info,
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
    Color accent = color ?? _resolveColor(state);
    String animationAsset = _resolveAnimation(state);

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

  Color _resolveColor(SmartProgressState state) {
    switch (state) {
      case SmartProgressState.success:
        return Colors.green;
      case SmartProgressState.failure:
        return Colors.red;
      case SmartProgressState.warning:
        return Colors.orange;
      case SmartProgressState.info:
        return Colors.blue;
      default:
        return Colors.teal;
    }
  }

  String _resolveAnimation(SmartProgressState state) {
    switch (state) {
      case SmartProgressState.success:
        return 'assets/success.json';
      case SmartProgressState.failure:
        return 'assets/error.json';
      case SmartProgressState.warning:
        return 'assets/warning.json';
      case SmartProgressState.info:
        return 'assets/info_alert.json';
      default:
        return 'assets/info_alert.json';
    }
  }
}
