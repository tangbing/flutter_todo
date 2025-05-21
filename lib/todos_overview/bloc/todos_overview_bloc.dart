

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/todos_overview/models/todos_view_filter.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_overview_event.dart';
part 'todos_overview_state.dart';

class TodosOverViewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {

  TodosOverViewBloc({required TodosRepository todosRepository})
      : _todosRepository= todosRepository,
  super(const TodosOverviewState()) {
    on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosOverviewTodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodosOverviewTodoDeleted>(_onTodoDeleted);
    on<TodosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TodosOverviewFilterChanged>(_onFilterChanged);
    on<TodosOverviewToggleAllRequested>(_onToggleAllRequested);
    on<TodosOverViewClearCompletedRequested>(_onClearCompletedRequested);
  }

  final TodosRepository _todosRepository;


  Future<void> _onSubscriptionRequested(TodosOverviewSubscriptionRequested event,
      Emitter<TodosOverviewState> emit) async {
       emit(state.copyWith(status: () => TodosOverViewStatus.loading));

       await emit.forEach<List<Todo>>(
        _todosRepository.getTodos(),
       onData: (todos) => state.copyWith(
         status: () => TodosOverViewStatus.success,
         todos: () => todos,
       ),
         onError: (_, __) => state.copyWith(
           status: () => TodosOverViewStatus.failure,
         ),
       );

  }

  Future<void> _onTodoCompletionToggled(TodosOverviewTodoCompletionToggled event ,Emitter<TodosOverviewState> emit) async {
      final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
      await _todosRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(TodosOverviewTodoDeleted event ,Emitter<TodosOverviewState> emit) async {
      emit(state.copyWith(lastDeletedTodo: () => event.todo));
      await _todosRepository.deleteTodo(event.todo.id);
  }

  Future<void> _onUndoDeletionRequested(TodosOverviewUndoDeletionRequested event ,Emitter<TodosOverviewState> emit) async {
    assert(
        state.lastDeletedTodo != null,
        'Last deleted todo can not be null.'
    );

    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: () => null));
    await _todosRepository.saveTodo(todo);
  }

  void _onFilterChanged(TodosOverviewFilterChanged event ,
      Emitter<TodosOverviewState> emit) {
      emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onToggleAllRequested(TodosOverviewToggleAllRequested event,
      Emitter<TodosOverviewState> emit) async {
      final areAllCompleted = state.todos.every((element) => element.isCompleted);
      await _todosRepository.clearCompleteAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompletedRequested(TodosOverViewClearCompletedRequested event,
      Emitter<TodosOverviewState> emit) async {
      await _todosRepository.clearCompleted();
  }


}