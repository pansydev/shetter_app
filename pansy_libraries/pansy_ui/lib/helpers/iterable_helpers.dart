extension UIterableExtensions<T> on Iterable<T> {
  Iterable<T> operator *(int times) {
    final list = <T>[];
    for (var i = 0; i < times; i++) {
      list.addAll(this);
    }
    return list;
  }
}
