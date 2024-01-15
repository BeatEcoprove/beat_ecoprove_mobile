import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/domain/models/group_list.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/groups_result.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class GetGroupsUseCase implements UseCaseAction<Future<GroupList>> {
  final GroupService _groupService;

  GetGroupsUseCase(this._groupService);

  @override
  Future<GroupList> handle() async {
    GroupsResult groupsResult;
    List<GroupItem> privateGroups = [];
    List<GroupItem> publicGroups = [];

    try {
      groupsResult = await _groupService.getGroups();
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
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
}
