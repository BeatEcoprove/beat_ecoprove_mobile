import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_form.dart';
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
      builder: (context, state) => GroupChatView(
        groupItem: state.extra as GroupItem,
      ),
    ),
    GoRoute(
      path: 'members',
      builder: (context, state) => GroupChatMembersView(
        groupParams: state.extra as GroupParams,
      ),
    ),
    GoRoute(
      path: 'update',
      builder: (context, state) => EditGroupView(
        params: state.extra as UpdateGroupParams,
      ),
    ),
    GoRoute(
      path: 'create',
      builder: (context, state) => const CreateGroupView(),
    ),
  ],
);
