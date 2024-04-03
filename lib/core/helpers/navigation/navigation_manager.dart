import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:go_router/go_router.dart';

abstract class INavigationManager {
  Future pushAsync<T>(AppRoute route, {T? extras});
  void push<T>(AppRoute route, {T? extras});
  void replaceTop<T>(AppRoute route, {T? extras});
  Future replaceTopAsync<T>(AppRoute route, {T? extras});
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
  void push<T>(AppRoute route, {T? extras}) {
    router.push(route.navigationPath, extra: extras);
  }

  @override
  Future pushAsync<T>(AppRoute route, {T? extras}) async {
    await router.push(route.navigationPath, extra: extras);
  }

  @override
  void replaceTop<T>(AppRoute route, {T? extras}) {
    router.pushReplacement(route.navigationPath, extra: extras);
  }

  @override
  Future replaceTopAsync<T>(AppRoute route, {T? extras}) {
    return router.pushReplacement(route.navigationPath, extra: extras);
  }
}
