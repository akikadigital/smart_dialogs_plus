# Smart Dialogs Plus

**Smart Dialogs Plus** is a complete Flutter UI feedback toolkit that combines animated dialogs, alerts, snackbars, pull-to-refresh indicators, and infinite scroll loaders. Built for modern apps that value clean, intuitive, and reactive feedback for every user interaction.

![Smart Dialogs Plus Banner](assets/logo.png)

---

## ✨ Features

* ✅ `SmartProgressDialog` with animations for loading, success, failure, and warning states
* ⚠️ `SmartAlertDialog` for confirmations, info, and warnings
* 🍞 `SmartSnackBar` for toast-like user feedback with flexible placement
* 🔁 `SmartRefreshIndicator` to wrap scroll views with pull-to-refresh
* 📆 `SmartListLoader` to append a loader during infinite scroll
* 🎮 `SmartProgressController` to manage dialog state transitions programmatically
* 🎨 Full customization of color, message, placement, and icons

---

## 🚀 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  smart_dialogs_plus: ^0.0.1
```

Import into your Dart files:

```dart
import 'package:smart_dialogs_plus/smart_dialogs_plus.dart';
```

---

## 🧠 Usage

### 1. Show Progress Dialog with Controller

```dart
final controller = SmartProgressController();
controller.attach(context);

controller.showLoading("Please wait...");
await Future.delayed(Duration(seconds: 2));
controller.showSuccess("All done!");
```

---

### 2. Inline Progress Dialog

```dart
showDialog(
  context: context,
  builder: (_) => SmartProgressDialog(
    state: SmartProgressState.warning,
    message: "Something might be wrong.",
    color: Colors.orange,
  ),
);
```

---

### 3. Show Alert Dialog

```dart
showDialog(
  context: context,
  builder: (_) => SmartAlertDialog(
    title: "Confirm Logout",
    message: "Are you sure you want to log out?",
    state: SmartProgressState.warning,
    onConfirm: () => print("User confirmed"),
  ),
);
```

---

### 4. Show Custom Snackbar

```dart
SmartSnackBar.show(
  context,
  "Item deleted successfully",
  state: SmartProgressState.success,
  position: SnackBarPosition.top,
  backgroundColor: Colors.green,
);
```

---

### 5. Load More in Infinite Scroll List

```dart
SmartListLoader(isLoading: isLoadingMore)
```

---

### 6. Pull to Refresh Integration

```dart
SmartRefreshIndicator(
  onRefresh: _refreshData,
  child: ListView.builder(...),
)
```

---

## 📂 File Structure

```bash
lib/
├── smart_dialogs_plus.dart             # Export entry
└── src/
    ├── smart_alert_dialog.dart         # Alert dialog with confirm/cancel
    ├── smart_progress_dialog.dart      # Animated progress feedback
    ├── smart_snack_bar.dart            # Flexible snackbar
    ├── smart_refresh_indicator.dart    # Pull to refresh wrapper
    ├── smart_list_loader.dart          # Infinite scroll loader
    ├── smart_progress_controller.dart  # Controller
    └── dialog_state.dart               # Enum of states
```

---

## 📸 Screenshots

| Type      | Preview                        |
| --------- | ------------------------------ |
| Loading   | ![](screenshots/loading.png)   |
| Success   | ![](screenshots/success.png)   |
| Warning   | ![](screenshots/warning.png)   |
| Error     | ![](screenshots/error.png)     |
| Snackbar  | ![](screenshots/snackbar.png)  |
| Alert     | ![](screenshots/alert.png)     |
| Refresh   | ![](screenshots/refresh.png)   |
| Load More | ![](screenshots/load_more.png) |

---

## 📄 License

MIT License © 2025 Akika Digital

---

## 💡 Contributing

Got ideas for more widgets or improvements? Submit an issue or pull request on GitHub. Let’s make feedback in Flutter apps smarter — together!

---

> **Smart Dialogs Plus** — One toolkit to handle all user feedback in Flutter apps.
