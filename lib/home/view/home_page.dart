import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/edit_todo/view/edit_todo_page.dart';
import 'package:flutter_todos/home/cubit/home_cubit.dart';
import 'package:flutter_todos/stats/view/stats_page.dart';
import 'package:flutter_todos/todos_overview/view/todos_overview_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    /// 用于监听 provider 中的数据，并且只对指定字段的变化做出响应，减少不必要的 widget 重建。
    /// 只能在 widget 的 build 方法中调用，不能在其他生命周期方法（如 didChangeDependencies）中用。
    /// 通过传入 selector（选择器），只监听你关心的那部分数据。
    /// 如果 selector 的返回值和上一次不同，widget 会重新构建；否则不会重建。
    /// 可以多次调用 select 监听多个字段。
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    
    print('select: ${selectedTab.index}');

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [TodosOverviewPage(), StatsPage()],
      ),
      floatingActionButton: FloatingActionButton(
          key: const Key('homeView_addTodo_floatingActionButton'),
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(EditTodoPage.route())),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.todos,
              icon: const Icon(Icons.list_rounded),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.stats,
              icon: const Icon(Icons.show_chart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton(
      {required this.groupValue, required this.value, required this.icon});

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => context.read<HomeCubit>().setTab(value),
        iconSize: 32,
        color: groupValue != value
            ? null
            : Theme.of(context).colorScheme.secondary,
        icon: icon);
  }
}
