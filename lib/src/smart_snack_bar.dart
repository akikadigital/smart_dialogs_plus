import 'package:flutter/material.dart';

import 'enums.dart';

/// A customizable snack bar utility for quick user feedback.
class SmartSnackBar {
  static void show(
    BuildContext context,
    String message, {
    String? title,
    SmartSnackBarType type = SmartSnackBarType.success,
    SnackBarDuration duration = SnackBarDuration.short,
    Color? backgroundColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    SnackBarAction? action,
    SnackBarClosedReason? Function()? onClose,
    SnackBarPosition position = SnackBarPosition.bottom,
    bool showCloseIcon = false,
    Color closeIconColor = Colors.white,
  }) {
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title != null && title.isNotEmpty,
            child: Column(
              children: [
                Text(
                  title ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          Text(message)
        ],
      ),
      backgroundColor: backgroundColor ?? getColor(type),
      duration: getDuration(duration),
      behavior: behavior,
      action: action,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      showCloseIcon: showCloseIcon,
      closeIconColor: closeIconColor,
      margin: position == SnackBarPosition.top
          ? const EdgeInsets.fromLTRB(16, 50, 16, 0)
          : const EdgeInsets.fromLTRB(16, 0, 16, 16),
    );

    /// Show the snackbar at the bottom or top of the screen based on position.
    /// Allows showing a number of snackbars at the same time.
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((SnackBarClosedReason reason) {
      ;
      if (onClose != null) {
        onClose();
      }
    });
  }

  static Color getColor(SmartSnackBarType type) {
    switch (type) {
      case SmartSnackBarType.success:
        return Colors.green;
      case SmartSnackBarType.error:
        return Colors.red;
      case SmartSnackBarType.warning:
        return Colors.orange;
      default:
        return Colors.teal;
    }
  }

  /// convert duration enum to Duration object
  static Duration getDuration(SnackBarDuration duration) {
    switch (duration) {
      case SnackBarDuration.long:
        return const Duration(seconds: 3);
      case SnackBarDuration.indefinite:
        return const Duration(days: 365); // effectively indefinite
      default:
        return const Duration(seconds: 3);
    }
  }
}

// const Duration(seconds: 3)
