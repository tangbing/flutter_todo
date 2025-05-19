import 'package:flutter/cupertino.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),

  );
  
  bootstrap(() => const App());
}
