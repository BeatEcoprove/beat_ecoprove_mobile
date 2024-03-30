import 'package:go_router/go_router.dart';

abstract class INavigationManager {
  Future pushAsync<T>(String path, {T? extras});
  void push<T>(String path, {T? extras});
  void replaceTop<T>(String path, {T? extras});
  Future replaceTopAsync<T>(String path, {T? extras});
  void pop();
}

class NavigationManager implements INavigationManager {
  late GoRouter router;

  NavigationManager(this.router);

  setRouter(GoRouter router) {
    this.router = router;
  }

  @override
  void pop() {
    router.pop();
  }

  @override
  void push<T>(String path, {T? extras}) {
    router.go(path, extra: extras);
  }

  @override
  Future pushAsync<T>(String path, {T? extras}) async {
    await router.push(path, extra: extras);
  }

  @override
  void replaceTop<T>(String path, {T? extras}) {
    router.pushReplacement(path, extra: extras);
  }

  @override
  Future replaceTopAsync<T>(String path, {T? extras}) {
    return router.pushReplacement(path, extra: extras);
  }
}
