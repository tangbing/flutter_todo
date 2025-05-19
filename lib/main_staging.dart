import 'package:flutter/cupertino.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  final todosApi = LocalStorageTodosApi(
      plugin: await SharedPreferences.getInstance(),

  );

  bootstrap(() => const App());
}
