import 'package:dio/dio.dart';

class TodosApi {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:3000/todos/';

  Future<List<dynamic>> getTodos() async {
    final response = await _dio.get(_baseUrl);
    return response.data;
  }

  Future<dynamic> createTodo(Map<String, dynamic> todoData) async {
    final response = await _dio.post(_baseUrl, data: todoData);
    return response.data;
  }

  Future<void> deleteTodo(String id) async {
    final url = '$_baseUrl$id';
    await _dio.delete(url);
  }

  Future<void> updateCompleted(String id, bool completed) async {
    final url = '$_baseUrl$id';
    await _dio.patch(url, data: {'completed': completed});
  }
}
