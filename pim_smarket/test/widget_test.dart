// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:pim_smarket/main.dart';

void main() {
  testWidgets('Sign in test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final firestore = FakeFirebaseFirestore();
    await tester.pumpWidget(const MyApp());

    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.text('Sign in'));
    await tester.pump();
  });
}
