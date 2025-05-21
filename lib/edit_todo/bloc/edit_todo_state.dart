

part of 'edit_todo_bloc.dart';

enum EditTodosStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditTodosStatus {
  bool get isLoadingOrSuccess => [
    EditTodosStatus.loading,
    EditTodosStatus.success,
  ].contains(this);
}

final class EditTodoState extends Equatable {
  const EditTodoState({
   this.status = EditTodosStatus.initial,
   this.initialTodo,
   this.title = '',
   this.description = '',
});

  final EditTodosStatus status;
  final Todo? initialTodo;
  final String title;
  final String description;

  bool get isNewTodo => initialTodo == null;

  EditTodoState copyWith({
    EditTodosStatus? status,
    Todo? initialTodo,
    String? title,
    String? description,
}) {
    return EditTodoState(
      status: status ?? this.status,
      initialTodo: initialTodo ?? this.initialTodo,
      title: title ?? this.title,
      description: description ?? this.description
    );
  }

  @override
  List<Object?> get props => [status, initialTodo, title, description];


}