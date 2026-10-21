import 'package:flutter_test/flutter_test.dart';
import 'package:paradise_cafe/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const ParadiseCafeApp());
    expect(find.byType(ParadiseCafeApp), findsOneWidget);
  });
}