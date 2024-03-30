import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute groupRoutes = GoRoute(
  name: 'group',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => IView.of<GroupView>(),
  routes: [
    GoRoute(
      path: 'chat',
      builder: (context, state) =>
          ArgumentedView.of<GroupChatView>(state.extra),
    ),
    GoRoute(
      path: 'members',
      builder: (context, state) =>
          ArgumentedView.of<GroupChatMembersView>(state.extra),
    ),
    GoRoute(
      path: 'update',
      builder: (context, state) =>
          ArgumentedView.of<EditGroupView>(state.extra),
    ),
    GoRoute(
      path: 'create',
      builder: (context, state) => IView.of<CreateGroupView>(),
    ),
  ],
);
