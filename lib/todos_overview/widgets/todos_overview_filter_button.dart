

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:flutter_todos/todos_overview/models/models.dart';



class TodosOverviewFilterButton extends StatelessWidget {
  const TodosOverviewFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final activeFilter = context.select((TodosOverViewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TodosViewFilter>(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        initialValue: activeFilter,
        tooltip: l10n.todosOverviewFilterTooltip,
        onSelected: (filter) {
              context
                  .read<TodosOverViewBloc>()
                  .add(TodosOverviewFilterChanged(filter: filter));
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: TodosViewFilter.all,
                child: Text(l10n.todosOverviewFilterAll),
            ),
            PopupMenuItem(
              value: TodosViewFilter.activeOnly,
              child: Text(l10n.todosOverviewFilterActiveOnly),
            ),
            PopupMenuItem(
              value: TodosViewFilter.completeOnly,
              child: Text(l10n.todosOverviewFilterCompletedOnly),
            ),
          ];
        },
      icon: const Icon(Icons.filter_list_rounded),
        );
  }
}
