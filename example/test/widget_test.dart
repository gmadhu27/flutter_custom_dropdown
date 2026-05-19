import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('selects an item from the normal dropdown', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('No item selected'), findsOneWidget);

    await tester.tap(find.text('Open Normal Custom Dropdown'));
    await tester.pumpAndSettle();

    expect(find.text('Select an Item'), findsOneWidget);
    expect(find.text('Option 1'), findsOneWidget);

    await tester.tap(find.text('Option 1'));
    await tester.pumpAndSettle();

    expect(find.text('Option 1'), findsOneWidget);
    expect(find.text('No item selected'), findsNothing);
  });
}
