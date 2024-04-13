import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/argument_view.dart';

extension GroupRoutes on AppRoute {
  static final group = AppRoute(path: "group");

  static final chat = AppRoute(path: "chat");

  static final members = AppRoute(path: "members");

  static final update = AppRoute(path: "update");

  static final create = AppRoute(path: "create");
}

final NavigationRoute groupRoute = NavigationRoute(
  route: GroupRoutes.group,
  view: (BuildContext context, GoRouterState state) =>
      LinearView.of<GroupView>(),
  routes: [
    NavigationRoute(
      route: GroupRoutes.chat,
      view: (context, state) => ArgumentView.of<GroupChatView>(state.extra),
    ),
    NavigationRoute(
      route: GroupRoutes.members,
      view: (context, state) =>
          ArgumentView.of<GroupChatMembersView>(state.extra),
    ),
    NavigationRoute(
      route: GroupRoutes.update,
      view: (context, state) => ArgumentView.of<EditGroupView>(state.extra),
    ),
    NavigationRoute(
      route: GroupRoutes.create,
      view: (context, state) => LinearView.of<CreateGroupView>(),
    ),
  ],
);
