import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitolnix/main.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(FitolnixApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
