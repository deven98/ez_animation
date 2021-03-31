import 'package:flutter_test/flutter_test.dart';

import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('tests start of animation', (tester) async {
    EzAnimation ezAnimation = EzAnimation(0.0, 100.0, Duration(seconds: 1));

    await tester.pumpWidget(Container());

    expect(ezAnimation.value, 0.0);
  });

  testWidgets('tests middle of animation', (tester) async {
    EzAnimation ezAnimation = EzAnimation(0.0, 100.0, Duration(seconds: 1));
    ezAnimation.start();

    await tester.pumpWidget(Container());
    await tester.pump(Duration(milliseconds: 500));
    ezAnimation.stop();

    expect(ezAnimation.value, 50.0);
  });

  testWidgets('tests completion of animation', (tester) async {
    EzAnimation ezAnimation = EzAnimation(0.0, 100.0, Duration(seconds: 1));
    ezAnimation.start();

    await tester.pumpWidget(Container());
    await tester.pump(Duration(seconds: 2));

    expect(ezAnimation.value, 100.0);
  });

  testWidgets('tests middle of curved animation', (tester) async {
    EzAnimation ezAnimation =
        EzAnimation(0.0, 100.0, Duration(seconds: 1), curve: Curves.bounceIn);
    ezAnimation.start();

    await tester.pumpWidget(Container());
    await tester.pump(Duration(milliseconds: 500));
    ezAnimation.stop();

    expect(ezAnimation.value, isNot(equals(50.0)));
  });
}
