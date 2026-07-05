extension ListExtension<T> on List<T> {
  bool get isNotEmpty => length > 0;

  bool get isEmpty => length == 0;

  List<T> copyWithInsert(int index, T item) {
    final newList = [...this];
    newList.insert(index, item);
    return newList;
  }

  List<T> copyWithRemoveAt(int index) {
    final newList = [...this];
    newList.removeAt(index);
    return newList;
  }
}
