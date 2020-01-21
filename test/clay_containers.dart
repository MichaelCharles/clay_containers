import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neumorphic_containers/clay_containers.dart';

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
