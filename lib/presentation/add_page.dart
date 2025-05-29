import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todotestapp/data/categories.dart';
import 'package:todotestapp/data/const.dart';
import '../logic/todos_provider.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  final _categoryManager = CategoryManager();
  late final List<String> _categories;

  @override
  void initState() {
    _categories = _categoryManager.categories;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveTodo() async {
    if (_titleController.text.isEmpty || _selectedCategory == null) return;
    final todoData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'category': _selectedCategory,
      'completed': false,
    };
    await ref.read(todosControllerProvider.notifier).addTodo(todoData);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(todosControllerProvider).isLoading;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kAppMaxWidth),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Название'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items:
                      _categories
                          .map(
                            (cat) =>
                                DropdownMenuItem(value: cat, child: Text(cat)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'Категория',
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: isLoading ? null : _saveTodo,
                  child:
                      isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text('Сохранить'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
