import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openhiit/main.dart';

import 'functions.dart';

const double portraitWidth = 1242.0;
const double portraitHeight = 2208.0;
const double landscapeWidth = portraitHeight;
const double landscapeHeight = portraitWidth;

void main() {
  testWidgets('Test CreateInterval', (WidgetTester tester) async {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();

    await binding.setSurfaceSize(const Size(portraitWidth, portraitHeight));

    String timerName = "Test interval timer 1";

    // Build our app and trigger a frame.
    await tester.pumpWidget(const WorkoutTimer());

    // Tap the '+' icon and trigger the add Workout or Timer page.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that the next page has loaded.
    expect(find.text('Interval Timer'), findsOneWidget);
    expect(find.text('Workout'), findsOneWidget);

    ///
    /// CREATE FORM
    ///

    // Tap to add a Workout.
    await tester.tap(find.byIcon(Icons.timer));
    await tester.pumpAndSettle();

    // Verify that the next page has loaded.
    expect(find.text('Enter a name:'), findsOneWidget);

    // Enter a name
    await tester.enterText(find.byKey(const Key('timer-name')), timerName);

    await createOrEditWorkout(
        tester,
        timerName,
        3,
        false,
        false,
        "Long whistle",
        "Ding",
        "Quick beep sequence",
        "Beep",
        "Horn",
        "60",
        "30");

    // Tap the workout to view details
    await tester.tap(find.text(timerName));

    await tester.pump(); // allow the application to handle

    await tester.pump(const Duration(seconds: 1)); // skip past the animation

    // Verify the ViewWorkout page has loaded
    expect(find.text("Start"), findsOneWidget);

    // Find and tap the edit button
    await tester.tap(find.byKey(const Key('edit-workout')));

    await tester.pump(); // allow the application to handle

    await tester.pump(const Duration(seconds: 1)); // skip past the animation

    await createOrEditWorkout(tester, timerName, 2, false, false, "Ding",
        "Long whistle", "Horn", "None", "Quick beep sequence", "90", "20");

    // Tap the workout to view details
    await tester.tap(find.text(timerName));

    await tester.pump(); // allow the application to handle

    await tester.pump(const Duration(seconds: 1)); // skip past the animation

    // Verify the ViewWorkout page has loaded
    expect(find.text("Start"), findsOneWidget);

    // Find and tap the delete button
    await tester.tap(find.byKey(const Key('delete-workout')));

    // Wait for the dialog to appear
    await tester.pump(const Duration(seconds: 1));

    // Verify that the dialog is displayed
    expect(find.text('Delete $timerName'), findsOneWidget);

    // Tap the Delete button in the dialog
    await tester.tap(find.text('Delete'));

    // Wait for the dialog to close
    await tester.pumpAndSettle();

    // Verify that the workout is no longer displayed
    expect(find.text(timerName), findsNothing);
  });
}
