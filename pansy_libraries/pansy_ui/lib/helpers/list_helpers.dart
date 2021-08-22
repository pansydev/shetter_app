extension UListExtensions<T> on List<T> {
  void replace(T from, T replace) => this[this.indexOf(from)] = replace;
}
