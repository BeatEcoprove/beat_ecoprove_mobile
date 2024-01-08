import 'package:beat_ecoprove/group/presentation/create_group/create_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute groupRoutes = GoRoute(
  name: 'group',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => const GroupView(),
  routes: [
    GoRoute(
      path: 'chat',
      builder: (context, state) => const GroupChatView(),
    ),
    GoRoute(
      path: 'members',
      builder: (context, state) => const GroupChatMembersView(),
    ),
    GoRoute(
      path: 'create',
      builder: (context, state) => const CreateGroupView(),
    ),
  ],
);
