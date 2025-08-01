/// Enum representing the visual state of the SmartProgressDialog.
enum SmartProgressState {
  /// Loading spinner
  loading,

  /// Success animation (✓)
  success,

  /// Info animation (i) - Optional, can be used for informational messages
  info,

  /// Failure animation (X)
  error,

  /// Warning animation (!)
  warning,
}

enum SmartAlertIconType {
  /// Success alert type
  success,

  /// Info alert type
  info,

  /// Warning alert type
  warning,

  /// Error alert type
  error,
}

enum SmartSnackBarType {
  /// Success snackbar type
  success,

  /// Info snackbar type
  info,

  /// Warning snackbar type
  warning,

  /// Error snackbar type
  error,
}

enum SmartSnackBarDuration {
  /// Short duration for snackbars
  short,

  /// Long duration for snackbars
  long,

  /// Indefinite duration for snackbars
  indefinite,
}

/// Enum for snackbar position.
enum SmartSnackBarPosition {
  /// Snackbar appears at the top of the screen.
  top,

  /// Snackbar appears at the bottom of the screen.
  bottom,
}

/// Enum for the alignment of buttons in the SmartAlertDialog.
enum SmartAlertDialogButtonAlignment {
  /// Buttons are aligned to the left.
  start,

  /// Buttons are aligned to the center.
  center,

  /// Buttons are aligned to the right.
  end,
}
