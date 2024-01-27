import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/domain/models/group_list.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/groups_result.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class GetGroupsUseCase
    implements UseCase<Map<String, String>, Future<GroupList>> {
  final GroupService _groupService;

  GetGroupsUseCase(this._groupService);

  @override
  Future<GroupList> handle(param) async {
    GroupsResult groupsResult;
    List<GroupItem> privateGroups = [];
    List<GroupItem> publicGroups = [];
    String searchParam = '';

    if (param.isNotEmpty) {
      searchParam = _prepareRequest(param);
    }

    try {
      groupsResult = await _groupService.getGroups(searchParam);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }

    for (var privateGroup in groupsResult.privateGroups) {
      var card = GroupItem(
        id: privateGroup.id,
        name: privateGroup.name,
        description: privateGroup.description,
        isPublic: privateGroup.isPublic,
        membersCount: privateGroup.membersCount,
        sustainablePoints: privateGroup.sustainablePoints,
        xp: privateGroup.xp,
        avatarPicture: privateGroup.avatarPicture,
      );

      privateGroups.add(card);
    }

    for (var publicGroup in groupsResult.publicGroups) {
      var card = GroupItem(
        id: publicGroup.id,
        name: publicGroup.name,
        description: publicGroup.description,
        isPublic: publicGroup.isPublic,
        membersCount: publicGroup.membersCount,
        sustainablePoints: publicGroup.sustainablePoints,
        xp: publicGroup.xp,
        avatarPicture: publicGroup.avatarPicture,
      );

      publicGroups.add(card);
    }

    return GroupList(globals: publicGroups, mine: privateGroups);
  }

  String _prepareRequest(Map<String, String> params) {
    Set<String> tags = {};
    String endPoint = '&';

    for (var param in params.values) {
      tags.add(param);
    }

    for (var tag in tags) {
      endPoint +=
          '$tag=${params.entries.where((entry) => entry.value.contains(tag)).map((entry) => entry.key).join(',')}';
      endPoint += '&';
    }

    return endPoint;
  }
}
