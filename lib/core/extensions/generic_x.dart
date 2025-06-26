extension GenericX<T, O> on T? {

  O? whenNotNull(O? Function(T) callback) {
    if (this == null) return null;
    return callback.call(this as T);
  }
}