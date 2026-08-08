import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lclgittest1/main.dart';

void main() {
  testWidgets('Snap Lab shows headline and tap button', (tester) async {
    await tester.pumpWidget(const SnapLabApp());

    expect(find.text('Snap Lab v1'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Tap'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
