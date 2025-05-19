// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:todos_repository/todos_repository.dart';

void main() {
  group('TodosRepository', () {
    test('can be instantiated', () {
      expect(TodosRepository(), isNotNull);
    });
  });
}
