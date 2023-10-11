abstract class UseCase<TRequest, TResponse> {
  TResponse handle(TRequest request);
}
