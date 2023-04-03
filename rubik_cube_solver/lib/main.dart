import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rubik_cube_solver/src/app.dart';

void main() {
  const myApp = MyAppTest();
  runApp(
    const ProviderScope(
      child: myApp,
    ),
  );
}
