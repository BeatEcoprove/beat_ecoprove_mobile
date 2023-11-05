abstract class HttpError<T> implements Exception {
  final Map<String, dynamic> result;
  final int statusCode;

  HttpError(this.result, this.statusCode);

  T getError();
}
