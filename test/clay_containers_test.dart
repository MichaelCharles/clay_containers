import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ClayContainer can have a child.', (WidgetTester tester) async {
    await tester.pumpWidget(
      ClayContainer(
        color: Colors.grey,
        child: Container(),
      ),
    );
  });
}
