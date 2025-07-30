import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_dialogs_plus/smart_dialogs_plus.dart';

void main() {
  testWidgets('SmartAlertDialog shows with title and message',
      (WidgetTester tester) async {
    bool confirmCalled = false;
    bool cancelCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  SmartAlertDialog.show(
                    context,
                    title: 'Test Title',
                    message: 'Test Message',
                    iconType: SmartAlertIconType.info,
                    onConfirm: () => confirmCalled = true,
                    onCancel: () => cancelCalled = true,
                  );
                },
                child: const Text('Show Alert'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Alert'));
    await tester.pump(); // start dialog animation
    await tester.pump(const Duration(milliseconds: 500)); // allow UI to render

    // Confirm title and message are present
    expect(find.text('Test Title'), findsAtLeastNWidgets(1));
    expect(find.text('Test Message'), findsOneWidget);

    // Tap Confirm
    await tester.tap(find.text('OK'));
    await tester.pump();

    expect(confirmCalled, isTrue);
    expect(cancelCalled, isFalse);
  });

  testWidgets('SmartAlertDialog triggers cancel callback',
      (WidgetTester tester) async {
    bool cancelCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  SmartAlertDialog.show(
                    context,
                    title: 'Alert',
                    message: 'Are you sure?',
                    onCancel: () => cancelCalled = true,
                  );
                },
                child: const Text('Cancel Alert'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Cancel Alert'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Alert'), findsAtLeastNWidgets(1));
    expect(find.text('Are you sure?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pump();

    expect(cancelCalled, isTrue);
  });

  testWidgets('SmartAlertDialog applies custom theme',
      (WidgetTester tester) async {
    final theme = SmartAlertDialogTheme(
      backgroundColor: Colors.black,
      titleTextColor: Colors.yellow,
      messageTextColor: Colors.white,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  SmartAlertDialog.show(
                    context,
                    title: 'Styled Alert',
                    message: 'Styled message.',
                    alertDialogTheme: theme,
                  );
                },
                child: const Text('Styled Alert'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Styled Alert'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Styled Alert'), findsAtLeastNWidgets(1));
    expect(find.text('Styled message.'), findsOneWidget);
  });
}
