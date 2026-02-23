import 'package:before_after_slider_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders before_after example', (tester) async {
    await tester.pumpWidget(const ExampleApp());

    expect(find.text('before_after_slider example'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });
}
