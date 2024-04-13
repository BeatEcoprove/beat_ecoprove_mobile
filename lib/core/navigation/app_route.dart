import 'package:flutter/material.dart';

class AppRoute {
  static final AppRoute root = AppRoute(
    path: "/",
    key: GlobalKey<NavigatorState>(),
  );

  late final String path;
  late GlobalKey<NavigatorState>? key;

  late AppRoute? parent;

  AppRoute({
    required this.path,
    this.key,
  });

  AppRoute.from(this.path) : parent = null;
  AppRoute.withParent(this.parent, this.path);
  AppRoute.withKey(this.parent, this.key) : path = "";

  String get navigationPath {
    if (parent == null) {
      return path;
    }

    if (parent == AppRoute.root) {
      return "${AppRoute.root.navigationPath}$path";
    }

    return "${parent!.navigationPath}${path.isEmpty ? '' : '/'}$path";
  }
}
