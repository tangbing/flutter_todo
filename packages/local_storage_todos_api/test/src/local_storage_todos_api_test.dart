// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';

void main() {
  group('LocalStorageTodosApi', () {
    test('can be instantiated', () {
      expect(LocalStorageTodosApi(), isNotNull);
    });
  });
}
