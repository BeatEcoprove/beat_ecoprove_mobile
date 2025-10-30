import 'package:beat_ecoprove/group/contracts/group_result.dart';

class GroupsResult {
  final List<GroupResult> groups;

  GroupsResult(
    this.groups,
  );

  factory GroupsResult.fromJson(Map<String, dynamic> json) {
    return GroupsResult(
      _convertJsonToGroupResult(json['data']),
    );
  }

  static List<GroupResult> _convertJsonToGroupResult(List<dynamic> groups) {
    var group = groups.map((item) {
      return GroupResult.fromJson(item);
    }).toList();
    return group;
  }
}
