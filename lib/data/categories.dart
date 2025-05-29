class Categories {
  final List<String> _categories = ['category1', 'category2'];

  List<String> get categories => List.unmodifiable(_categories);

  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
    }
  }

  void removeCategory(String category) {
    _categories.remove(category);
  }
}
