abstract class UseCase<TRequest, TResponse> {
  TResponse handle(TRequest request);
}

abstract class UseCaseAction<TResponse> {
  TResponse handle();
}
