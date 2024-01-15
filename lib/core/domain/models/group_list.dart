import 'package:beat_ecoprove/core/domain/models/group_item.dart';

class GroupList {
  final List<GroupItem> globals; // all the public groups
  final List<GroupItem> mine; // privates and publics from authenticated user

  GroupList({required this.globals, required this.mine});
}
