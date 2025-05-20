

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_event.dart';

@visibleForTesting
enum TodosOverviewOption { toggleAll, clearCompleted }

class TodoOverviewOptionsButton extends StatelessWidget {
  const TodoOverviewOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final todos = context.select((TodosOverViewBloc bloc) => bloc.state.todos);
    final hasTodos = todos.isNotEmpty;
    final completedTodosAmount = todos.where((todo) => todo.isCompleted).length;

    return PopupMenuButton<TodosOverviewOption>(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        tooltip: l10n.todosOverviewOptionsTooltip,
        onSelected: (options) {
          switch (options) {
            case TodosOverviewOption.toggleAll:
              context.read<TodosOverViewBloc>().add(const TodosOverviewToggleAllRequested());
            case TodosOverviewOption.clearCompleted:
                context.read<TodosOverViewBloc>().add(const TodosOverViewClearCompletedRequested());
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                child: Text(completedTodosAmount == todos.length
                    ? l10n.todosOverviewOptionsMarkAllIncomplete :
                      l10n.todosOverviewOptionsMarkAllComplete,
                ),
            ),
            PopupMenuItem(
                value: TodosOverviewOption.clearCompleted,
                enabled: hasTodos && completedTodosAmount > 0,
                child: Text(l10n.todosOverviewOptionsClearCompleted),
            ),
          ];
        },
      icon: const Icon(Icons.more_vert_rounded),
        );
  }
}
