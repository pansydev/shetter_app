Stream<T> Function() keep<T>(T state) {
  return () async* {
    yield state;
  };
}
