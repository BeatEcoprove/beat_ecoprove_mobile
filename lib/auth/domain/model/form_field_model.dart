class FormFieldModel<T> {
  late dynamic _value;
  late String _error;

  FormFieldModel.empty() {
    _error = '';
    _value = null;
  }

  T get value => _value == null ? "" as T : _value as T;
  String get error => _error;

  void setValue(T value) {
    _value = value;
  }

  void setError(String error) {
    _error = error;
  }

  void clean() {
    _error = "";
  }
}
