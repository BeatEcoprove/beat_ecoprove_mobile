import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/group/contracts/accept_member_request.dart';
import 'package:beat_ecoprove/group/contracts/chat_messages.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/contracts/groups_result.dart';
import 'package:beat_ecoprove/group/contracts/invite_member_request.dart';
import 'package:beat_ecoprove/group/contracts/leave_group_request.dart';
import 'package:beat_ecoprove/group/contracts/register_group_request.dart';
import 'package:beat_ecoprove/group/contracts/register_trade_request.dart';
import 'package:beat_ecoprove/group/contracts/update_group_request.dart';

class GroupService {
  final HttpAuthClient _httpClient;

  GroupService(this._httpClient);

  Future<GroupsResult> getGroups(int pageSize, String params) async {
    return GroupsResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "messaging/groups?limit=$pageSize&$params",
      expectedCode: 200,
    ));
  }

  // FIXME: See Server
  // Future<GroupsResult> getPublicGroups(int pageSize, String params) async {
  //   return GroupsResult.fromJson(await _httpClient.makeRequestJson(
  //     method: HttpMethods.get,
  //     path: "messaging/groups?limit=$pageSize&$params",
  //     expectedCode: 200,
  //   ));
  // }

  Future<GroupDetailsResult> getGroupDetails(String groupId) async {
    return GroupDetailsResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "messaging/groups/$groupId",
      expectedCode: 200,
    ));
  }

  Future registerGroup(RegisterGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.post,
      path: "messaging/groups",
      body: request,
      expectedCode: 201,
    );
  }

  Future updateGroup(UpdateGroupRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.put,
      path: "messaging/groups/${request.groupId}",
      body: request,
      expectedCode: 200,
    );
  }

  Future leaveGroup(LeaveGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.delete,
      path: "messaging/groups/${request.groupId}/kick",
      body: request,
      expectedCode: 200,
    );
  }

  Future changeMemberRole(ActionToMemberOfGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "messaging/groups/${request.groupId}/role?name=${request.role}",
      expectedCode: 200,
    );
  }

  Future acceptMember(InviteTokenRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "messaging/invites/accept",
      body: request,
      expectedCode: 200,
    );
  }

  Future deniedMember(InviteTokenRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "messaging/invites/decline",
      body: request,
      expectedCode: 200,
    );
  }

  Future inviteMember(InviteMemberRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "messaging/groups/${request.groupId}/invites",
      body: request,
      expectedCode: 200,
    );
  }

  Future<ChatMessages> getMessages(String groupId) async {
    var response = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "messaging/groups/$groupId/messages?page=1&pageSize=10000",
      expectedCode: 200,
    );

    return await ChatMessages.fromApi(response, groupId);
  }

  //FIXME:
  Future makeTrade(RegisterTradeRequest request) async {
    var response = await _httpClient.makeRequestJson(
      method: HttpMethods.post,
      path: "messaging/groups/${request.groupId}/messages/${request.messageId}",
      body: request,
      expectedCode: 200,
    );

    return response;
  }
}
