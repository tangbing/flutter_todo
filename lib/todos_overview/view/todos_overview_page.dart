import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/l10n/l10n.dart';
import 'package:flutter_todos/todos_overview/todo_overview.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosOverviewPage extends StatelessWidget {
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      TodosOverViewBloc(
        todosRepository: context.read<TodosRepository>(),
      )
        ..add(const TodosOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
          title: Text(l10n.todosOverviewAppBarTitle),
          actions: const [
            TodosOverviewFilterButton(),
            TodosOverviewOptionsButton(),
          ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodosOverViewBloc, TodosOverviewState>(
              listenWhen: (previous, current) =>
              previous.status != current.status,
              listener: (context, state) {
                if (state.status == TodosOverViewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: (Text(l10n.todosOverviewErrorSnackbarText)
                        ),
                      ),
                    );
                }
              }),
          BlocListener<TodosOverViewBloc, TodosOverviewState>(
              listenWhen: (previous, current) =>
              previous.lastDeletedTodo != current.lastDeletedTodo &&
                  current.lastDeletedTodo != null,
              listener: (context, state) {
                final deletedTodo = state.lastDeletedTodo!;
                final messenger = ScaffoldMessenger.of(context);
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                      SnackBar(content: Text(
                        l10n.todosOverviewTodoDeletedSnackbarText(
                          deletedTodo.title,
                        ),
                      ),
                        action: SnackBarAction(
                            label: l10n.todosOverviewUndoDeletionButtonText,
                            onPressed: () {
                              messenger.hideCurrentSnackBar();
                              context.read<TodosOverViewBloc>()
                                  .add(
                                  const TodosOverviewUndoDeletionRequested());
                            }),
                      )
                  );
              }),

        ],
        child: BlocBuilder<TodosOverViewBloc, TodosOverviewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosOverViewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              }  else if (state.status != TodosOverViewStatus.success) {
                return const SizedBox();
              } else {
                return Center(child: Text(l10n.todosOverviewEmptyText,
                  style: Theme.of(context).textTheme.bodySmall,
                ));
              }
            }
            return CupertinoScrollbar(
              child: ListView.builder(
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (context, index) {
                     final todo = state.filteredTodos.elementAt(index);
                     return TodoListTitle(todo: todo);
                  }),
            );

          },

        ),
      ),
    );
  }
}

