import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Container builds successfully', (tester) async {
    await tester.pumpWidget(Container());

    expect(find.byType(Container), findsOneWidget);
  });
}
