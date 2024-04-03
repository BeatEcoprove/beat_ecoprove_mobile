class AppRoute {
  static final AppRoute root = AppRoute(path: "/");

  late final String path;
  late AppRoute? parent;

  AppRoute({
    required this.path,
  });

  AppRoute.from(this.path) : parent = null;
  AppRoute.withParent(this.parent, this.path);

  String get navigationPath {
    if (parent == null) {
      return path;
    }

    if (parent == AppRoute.root) {
      return "${AppRoute.root.navigationPath}$path";
    }

    return "${parent!.navigationPath}/$path";
  }
}
