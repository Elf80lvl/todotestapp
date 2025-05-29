import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todotestapp/data/const.dart';
import 'package:todotestapp/presentation/add_page.dart';
import '../logic/todos_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? _selectedCategory;

  List<String> _extractCategories(List todos) {
    final set = <String>{};
    for (final todo in todos) {
      final cat = todo['category']?.toString() ?? '';
      if (cat.isNotEmpty) set.add(cat);
    }
    return set.toList();
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todosListProvider);
    return Scaffold(
      body: todosAsync.when(
        data: (todos) {
          final categories = _extractCategories(todos);
          final filteredTodos =
              _selectedCategory == null
                  ? todos
                  : todos
                      .where((t) => t['category'] == _selectedCategory)
                      .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 56,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1,
                  itemBuilder: (context, index) {
                    final isAll = index == 0;
                    final cat = isAll ? null : categories[index - 1];
                    final selected =
                        _selectedCategory == cat ||
                        (isAll && _selectedCategory == null);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: ChoiceChip(
                        label: Text(isAll ? 'Все' : cat!),
                        selected: selected,
                        onSelected: (_) {
                          setState(
                            () => _selectedCategory = isAll ? null : cat,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    filteredTodos.isEmpty
                        ? const Center(child: Text('Нет задач'))
                        : ListView.builder(
                          itemCount: filteredTodos.length,
                          itemBuilder: (context, index) {
                            final todo = filteredTodos[index];
                            return ListTile(
                              onTap: () async {
                                final id = todo['id']?.toString();
                                if (id != null) {
                                  await ref
                                      .read(todosControllerProvider.notifier)
                                      .toggleCompleted(
                                        id,
                                        !(todo['completed'] == true),
                                      );
                                }
                              },
                              title: Text(
                                todo['title']?.toString() ?? 'Без названия',
                                style: TextStyle(
                                  color:
                                      todo['completed']
                                          ? kColorTextCompletedLightTheme
                                          : kColorTextLightTheme,
                                  decoration:
                                      todo['completed']
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                ),
                              ),
                              subtitle: Text(
                                todo['description']?.toString() ?? '',
                                style: TextStyle(
                                  color:
                                      todo['completed']
                                          ? kColorTextCompletedLightTheme
                                          : kColorTextLightTheme,
                                  decoration:
                                      todo['completed']
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(todo['category']?.toString() ?? ''),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 17),

                                    onPressed: () async {
                                      final id = todo['id']?.toString();
                                      if (id != null) {
                                        await ref
                                            .read(
                                              todosControllerProvider.notifier,
                                            )
                                            .deleteTodo(id);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка: ${e.toString()}')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => AddPage()),
          );
        },
        label: Icon(Icons.add),
      ),
    );
  }
}
