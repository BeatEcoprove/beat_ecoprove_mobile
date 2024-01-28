import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/contracts/groups_result.dart';
import 'package:beat_ecoprove/group/contracts/invite_member_request.dart';
import 'package:beat_ecoprove/group/contracts/register_group_request.dart';
import 'package:beat_ecoprove/group/contracts/update_group_request.dart';

class GroupService {
  final HttpAuthClient _httpClient;

  GroupService(this._httpClient);

  Future<GroupsResult> getGroups(String param) async {
    return GroupsResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "groups?page=1$param",
      expectedCode: 200,
    ));
  }

  Future<GroupDetailsResult> getGroupDetails(String groupId) async {
    return GroupDetailsResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "groups/$groupId",
      expectedCode: 200,
    ));
  }

  Future registerGroup(RegisterGroupRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "groups",
      body: request,
      expectedCode: 200,
    );
  }

  Future updateGroup(UpdateGroupRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.put,
      path: "groups/${request.groupId}/update/${request.adminId}",
      body: request,
      expectedCode: 200,
    );
  }

  Future leaveGroup(ActionToMemberOfGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "groups/${request.groupId}/kick/${request.memberId}",
      body: request,
      expectedCode: 200,
    );
  }

  Future promoteMember(ActionToMemberOfGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "groups/${request.groupId}/promote/${request.memberId}/admin",
      body: request,
      expectedCode: 200,
    );
  }

  Future inviteMember(InviteMemberRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "groups/${request.groupId}/invite/${request.memberId}",
      expectedCode: 200,
    );
  }
}
