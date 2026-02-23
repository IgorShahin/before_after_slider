import 'package:before_after_slider_showcase/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders showcase app', (tester) async {
    await tester.pumpWidget(const DemoApp());

    expect(find.text('Web Demo Showcase'), findsOneWidget);
  });
}
