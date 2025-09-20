import 'package:flutter/material.dart';import 'package:flutter/material.dart';import 'package:flutter/material.dart';import 'package:flutter/material.dart';import 'package:flutter_test/flutter_test.dart';import 'package:flutter_test/flutter_test.dart';// This is a basic Flutter widget test.// Thisimport 'package:flutter_test/test.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:fitolnix/main.dart';import 'package:flutter_test/flutter_test.dart';



void main() {import 'package:fitolnix/main.dart';import 'package:flutter_test/flutter_test.dart';

  testWidgets('App starts without crashing', (WidgetTester tester) async {

    await tester.pumpWidget(FitolnixApp());

    expect(find.byType(MaterialApp), findsOneWidget);

  });void main() {import 'package:fitolnix/main.dart';import 'package:flutter_test/flutter_test.dart';

}
  testWidgets('App starts without crashing', (WidgetTester tester) async {

    // Build our app and trigger a frame.

    await tester.pumpWidget(FitolnixApp());

void main() {import 'package:fitolnix/main.dart';import 'package:fitolnix/main.dart';

    // Verify that our app starts successfully

    expect(find.byType(MaterialApp), findsOneWidget);  testWidgets('App starts without crashing', (WidgetTester tester) async {

  });

}    // Build our app and trigger a frame.

    await tester.pumpWidget(FitolnixApp());

void main() {import 'package:fitolnix/main.dart';

    // Verify that our app starts successfully

    expect(find.byType(MaterialApp), findsOneWidget);  testWidgets('App starts without crashing', (WidgetTester tester) async {

  });

}    // Build our app and trigger a frame.void main() {

    await tester.pumpWidget(FitolnixApp());

  testWidgets('App starts without crashing', (WidgetTester tester) async {//

    // Verify that our app starts successfully

    expect(find.byType(MaterialApp), findsOneWidget);    await tester.pumpWidget(FitolnixApp());

  });

}    expect(find.byType(FitolnixApp), findsOneWidget);void main() {

  });

}  testWidgets('App starts without crashing', (WidgetTester tester) async {// To perform an interaction with a widget in your test, use the WidgetTesterimport 'package:fitolnix/main.dart';a basic Flutter widget test.

    await tester.pumpWidget(FitolnixApp());

    expect(find.byType(FitolnixApp), findsOneWidget);// utility in the flutter_test package. For example, you can send tap and scroll//

  });

}// gestures. You can also use WidgetTester to find child widgets in the widget// To perform an interaction with a widget in your test, use the WidgetTester

// tree, read text, and verify that the values of widget properties are correct.// utility in the flutter_test package. For example, you can send tap and scroll

// gestures. You can also use WidgetTester to find child widgets in the widget

import 'package:flutter_test/flutter_test.dart';// tree, read text, and verify that the values of widget properties are correct.



import 'package:fitolnix/main.dart';import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('App should start without crashing', (WidgetTester tester) async {import 'package:fitolnix/main.dart';

    // Build our app and trigger a frame.

    await tester.pumpWidget(FitolnixApp());void main() {

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    // Verify that the app starts    // Build our app and trigger a frame.

    expect(find.byType(FitolnixApp), findsOneWidget);    await tester.pumpWidget(FitolnixApp());

  });

}    // Verify that our counter starts at 0.
    expect(find.text('0'), findsNothing);
    expect(find.text('Welcome to Fitolnix'), findsOneWidget);
  });
}
