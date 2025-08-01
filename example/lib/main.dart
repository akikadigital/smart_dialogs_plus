import 'package:flutter/material.dart';
import 'package:smart_dialogs_plus/smart_dialogs_plus.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Smart Progress Dialog Example',
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final List<String> _items = List.generate(20, (i) => 'Item ${i + 1}');
  bool _isLoadingMore = false;

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _items.addAll(List.generate(10, (i) => 'Item ${_items.length + i + 1}'));
      _isLoadingMore = false;
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _items.clear();
      _items.addAll(List.generate(20, (i) => 'Item ${i + 1}'));
    });
  }

  void _simulateSuccess() async {
    SmartProgressDialog.showProgressDialog(context,
        color: Colors.black87, text: "Loading...");
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    SmartProgressDialog.dismissProgressDialog(
      context,
      SmartProgressState.success,
      text: "Successful",
    ); // Show success state
  }

  void _simulateInfo() async {
    SmartProgressDialog.showProgressDialog(context, text: "Processing...");
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    SmartProgressDialog.dismissProgressDialog(
      context,
      SmartProgressState.info,
      text: "This is an Info!",
    ); // Show info state
  }

  void _simulateWarning() async {
    SmartProgressDialog.showProgressDialog(context, text: "Processing...");
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    SmartProgressDialog.dismissProgressDialog(
      context,
      SmartProgressState.warning,
      text: "This is a warning!",
    ); // Show info state
  }

  void _simulateError() async {
    SmartProgressDialog.showProgressDialog(context, text: "Processing...");
    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
    SmartProgressDialog.dismissProgressDialog(
      context,
      SmartProgressState.error,
      text: "There was an Error!",
    ); // Show info state
  }

  void _showSnackBar() {
    SmartSnackBar.show(context, "This is a snack bar message",
        type: SmartSnackBarType.warning,
        duration: SmartSnackBarDuration.short,
        position: SmartSnackBarPosition.top,
        backgroundColor: Colors.red,
        showIcon: false);

    SmartSnackBar.show(context, "This is a snack bar message",
        title: 'Some title',
        type: SmartSnackBarType.success,
        duration: SmartSnackBarDuration.indefinite,
        position: SmartSnackBarPosition.bottom,
        showIcon: true,
        showCloseIcon: true, onClose: () {
      SmartSnackBar.show(context, "Snack bar closed",
          type: SmartSnackBarType.info, duration: SmartSnackBarDuration.short);
      return null;
    });
  }

  void _showAlertDialog() {
    SmartAlertDialog.show(context,
        title: "Delete Item",
        titleFontSize: 28,
        message: "Are you sure you want to delete this?",
        messageFontSize: 24,
        iconType: SmartAlertIconType.info,
        animateAsset: true,
        loopAnimation: false,
        barrierDismissible: true,
        confirmText: "Delete",
        showCancel: true,
        cancelText: "Cancel",
        alertDialogTheme: SmartAlertDialogTheme(
          buttonsBorderRadius: BorderRadius.circular(8),
          backgroundColor: Colors.green,
          titleTextColor: Colors.white,
          messageTextColor: Colors.grey[700],
          confirmButtonTextColor: Colors.white,
          confirmButtonBackgroundColor: Colors.red,
          cancelButtonTextColor: Colors.white,
        ),
        onConfirm: () => SmartSnackBar.show(
              context,
              "Item deleted successfully",
              type: SmartSnackBarType.success,
            ),
        onCancel: () {
          SmartSnackBar.show(
            context,
            "Item deletion cancelled",
            type: SmartSnackBarType.info,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Dialogs Plus Example')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Buttons to trigger different states
                ElevatedButton(
                  onPressed: _simulateSuccess,
                  child: const Text("Show Success"),
                ),
                ElevatedButton(
                  onPressed: _simulateInfo,
                  child: const Text("Show Info"),
                ),
                ElevatedButton(
                  onPressed: _simulateWarning,
                  child: const Text("Show Warning"),
                ),
                ElevatedButton(
                  onPressed: _simulateError,
                  child: const Text("Show Error"),
                ),
                ElevatedButton(
                  onPressed: _showSnackBar,
                  child: const Text("Show Snack bar"),
                ),
                ElevatedButton(
                  onPressed: _showAlertDialog,
                  child: const Text("Show Alert Dialog"),
                ),
              ],
            ),
          ),
          Expanded(
            child: SmartRefreshIndicator(
              onRefresh: _refresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (!_isLoadingMore &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    _loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: _items.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _items.length) {
                      return SmartListLoader(isLoading: _isLoadingMore);
                    }
                    return ListTile(title: Text(_items[index]));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
