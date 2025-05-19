

import 'package:equatable/equatable.dart';
import 'package:todos_api/todos_api.dart';

enum TodosOverViewStatus { initial, loading, success, failure }


final class TodosOverviewState extends Equatable {

  const TodosOverviewState({
   this.status = TodosOverViewStatus.initial,
   this.todos = const [],
   this.filter = TodosViewFilter.all,
   this.lastDeletedTodo,
  });

  final TodosOverViewStatus status;
  final List<Todo> todos;
  final TodosViewFilter filter;
  final Todo? lastDeletedTodo;

  Iterable<Todo> get filteredTodos => filter.applyAll(todos);

  TodosOverviewState copyWith({
    TodosOverViewStatus Function()? status,
    List<Todo> Function()? todos,
    TodosViewFilter Function()? filter,
    Todo? Function()? lastDeletedTodo
}) {
    return TodosOverviewState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      filter: filter != null ? filter() : this.filter,
      lastDeletedTodo: lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [status, todos, filter, lastDeletedTodo];


}