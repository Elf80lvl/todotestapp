class CategoryManager {
  final List<String> _categories = [];

  // Получить все категории
  List<String> get categories => List.unmodifiable(_categories);

  // Добавить новую категорию
  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
    }
  }

  // Удалить категорию
  void removeCategory(String category) {
    _categories.remove(category);
  }
}
