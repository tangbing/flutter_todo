
part of 'todos_overview_bloc.dart';


sealed class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}

/// 这是启动事件。作为响应，bloc 订阅了来自 的待办事项流TodosRepository
final class TodosOverviewSubscriptionRequested extends TodosOverviewEvent {
  const TodosOverviewSubscriptionRequested();
}

/// 这将切换待办事项的完成状态
final class TodosOverviewTodoCompletionToggled extends TodosOverviewEvent {

  const TodosOverviewTodoCompletionToggled({
    required this.todo,
    required this.isCompleted
});

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];

}

/// 这将删除待办事项
final class TodosOverviewTodoDeleted extends TodosOverviewEvent {
  const TodosOverviewTodoDeleted({
    required this.todo
});
  final Todo todo;

  @override
  List<Object> get props => [todo];
}

/// 这将撤消待办事项删除，例如意外删除
final class TodosOverviewUndoDeletionRequested extends TodosOverviewEvent {
  const TodosOverviewUndoDeletionRequested();
}
/// 这将以TodosViewFilter作为参数并通过应用过滤器来改变视图
class TodosOverviewFilterChanged extends TodosOverviewEvent {
  const TodosOverviewFilterChanged({required this.filter});

  final TodosViewFilter filter;

  @override
  List<Object> get props => [filter];
}
/// 这将切换所有待办事项的完成
class TodosOverviewToggleAllRequested extends TodosOverviewEvent {
  const TodosOverviewToggleAllRequested();
}
/// 这将删除所有已完成的待办事项
class TodosOverViewClearCompletedRequested extends TodosOverviewEvent {
  const TodosOverViewClearCompletedRequested();
}





