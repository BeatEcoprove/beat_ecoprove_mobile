import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/group/contracts/accept_member_request.dart';
import 'package:beat_ecoprove/group/contracts/chat_messages.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/contracts/groups_result.dart';
import 'package:beat_ecoprove/group/contracts/invite_member_request.dart';
import 'package:beat_ecoprove/group/contracts/register_group_request.dart';
import 'package:beat_ecoprove/group/contracts/register_trade_request.dart';
import 'package:beat_ecoprove/group/contracts/update_group_request.dart';

class GroupService {
  final HttpAuthClient _httpClient;

  GroupService(this._httpClient);

  Future<GroupsResult> getGroups(int page, int pageSize, String params) async {
    return GroupsResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "groups?page=$page&pageSize=$pageSize&$params",
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

  Future despromoveMember(ActionToMemberOfGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "groups/${request.groupId}/promote/${request.memberId}/member",
      body: request,
      expectedCode: 200,
    );
  }

  Future acceptMember(AcceptMemberOnGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "groups/${request.groupId}/invite/${request.code}/accept",
      body: request,
      expectedCode: 200,
    );
  }

  Future deniedMember(AcceptMemberOnGroupRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.patch,
      path: "groups/${request.groupId}/invite/${request.code}/decline",
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

  Future<ChatMessages> getMessages(String groupId) async {
    var response = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "groups/$groupId/messages",
      expectedCode: 200,
    );

    return ChatMessages.fromJson(response);
  }

  Future makeTrade(RegisterTradeRequest request) async {
    var response = await _httpClient.makeRequestJson(
      method: HttpMethods.post,
      path: "groups/${request.groupId}/messages/${request.messageId}",
      body: request,
      expectedCode: 200,
    );

    return response;
  }
}
