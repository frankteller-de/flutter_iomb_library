import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_iomb_library_example/main.dart';

void main() {
  testWidgets('example renders without starting measurement sessions', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('IombLibrary Plugin'), findsOneWidget);
    expect(find.text('Running'), findsOneWidget);
  });
}
