// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:todos_api/todos_api.dart';

void main() {
  group('TodosApi', () {
    test('can be instantiated', () {
      expect(TodosApi(), isNotNull);
    });
  });
}
