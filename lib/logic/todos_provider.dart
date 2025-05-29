import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/todos_api.dart';

final todosApiProvider = Provider<TodosApi>((ref) => TodosApi());

final todosListProvider = FutureProvider<List<dynamic>>((ref) async {
  final api = ref.watch(todosApiProvider);
  return await api.getTodos();
});

class TodosController extends AsyncNotifier<void> {
  late final TodosApi _api;

  @override
  Future<void> build() async {
    _api = ref.read(todosApiProvider);
  }

  Future<void> addTodo(Map<String, dynamic> todoData) async {
    await _api.createTodo(todoData);
    ref.invalidate(todosListProvider);
  }

  Future<void> deleteTodo(String id) async {
    await _api.deleteTodo(id);
    ref.invalidate(todosListProvider);
  }

  Future<void> toggleCompleted(String id, bool completed) async {
    await _api.updateCompleted(id, completed);
    ref.invalidate(todosListProvider);
  }
}

final todosControllerProvider = AsyncNotifierProvider<TodosController, void>(
  TodosController.new,
);
