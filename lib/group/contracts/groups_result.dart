import 'package:beat_ecoprove/group/contracts/group_result.dart';

class GroupsResult {
  final List<GroupResult> publicGroups;
  final List<GroupResult> privateGroups;

  GroupsResult(
    this.publicGroups,
    this.privateGroups,
  );

  factory GroupsResult.fromJson(Map<String, dynamic> json) {
    return GroupsResult(
      _convertJsonToGroupResult(json['publicGroups']),
      _convertJsonToGroupResult(json['privateGroups']),
    );
  }

  static List<GroupResult> _convertJsonToGroupResult(List<dynamic> groups) {
    var group = groups.map((item) {
      return GroupResult.fromJson(item);
    }).toList();
    return group;
  }
}
