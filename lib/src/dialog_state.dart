/// Enum representing the visual state of the SmartProgressDialog.
enum SmartProgressState {
  /// Loading spinner
  loading,

  /// Success animation (✓)
  success,

  /// Failure animation (X)
  failure,

  /// Warning animation (!)
  warning,

  /// Info animation (ℹ️) - Optional, can be used for informational messages
  info,
}
