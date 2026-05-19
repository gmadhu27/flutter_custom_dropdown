import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('selects a country from the dropdown', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Select country'), findsOneWidget);
    expect(find.text('Normal sheet'), findsOneWidget);
    expect(find.text('Modal sheet'), findsOneWidget);
    expect(find.text('Full screen'), findsOneWidget);

    await tester.tap(find.text('Normal sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Search country / code'), findsOneWidget);
    expect(find.text('AVAILABLE MARKETS'), findsOneWidget);

    await tester.tap(find.text('Angola'));
    await tester.pumpAndSettle();

    expect(find.text('🇦🇴  Angola'), findsOneWidget);

    expect(find.text('Modal sheet'), findsOneWidget);
    expect(find.text('Full screen'), findsOneWidget);
  });
}
