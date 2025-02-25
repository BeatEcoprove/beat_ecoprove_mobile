import 'package:beat_ecoprove/group/domain/value_objects/group_type.dart';

class GroupChatParams {
  final String groupId;
  final String title;
  final GroupType state;
  final String numberMembers;

  GroupChatParams({
    required this.groupId,
    required this.title,
    required this.state,
    required this.numberMembers,
  });
}
