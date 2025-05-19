import 'package:todos_api/todos_api.dart';
/// {@template todos_repository}
// A repository that handles `todo` related requests.
/// {@endtemplate}
class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository(
  {
    required TodosApi todosApi,
}) : _todosApi = todosApi;

  final TodosApi _todosApi;

  Stream<List<Todo>> getTodos() => _todosApi.getTodos();

  Future<void> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);

  Future<void> clearCompleteAll({required bool isCompleted}) => _todosApi.completeAll(isCompleted: isCompleted);

  Future<void> clearCompleted() => _todosApi.clearCompleted();

  void dispose() => _todosApi.close();

}
