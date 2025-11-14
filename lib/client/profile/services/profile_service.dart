import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/core/providers/notifications/types/invite_group_notification.dart';
import 'package:beat_ecoprove/client/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/client/profile/contracts/promote_profile_request.dart';

class ProfileService {
  final HttpAuthClient _httpClient;

  ProfileService(
    this._httpClient,
  );

  Future<ProfilesResult> getAllProfiles(int page, int pageSize,
      {String search = ""}) async {
    var result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "core/profiles?search=$search&page=$page&pageSize=$pageSize",
      expectedCode: 200,
    );

    return ProfilesResult.fromJson(result);
  }

  Future removeNestedProfile(String profileId) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.delete,
      path: "core/profiles/$profileId",
      expectedCode: 200,
    );
  }

  Future promoteNestedProfile(PromoteProfileRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.put,
      path: "core/profiles/${request.profileId}/promote",
      body: request,
      expectedCode: 200,
    );
  }

  Future<AuthResult> registerProfile() async {
    return await _httpClient.makeRequestJson(
      method: HttpMethods.post,
      path: "auth/account/profiles/reserve",
      expectedCode: 200,
    );
  }

  Future<List<InviteToGroupNotification>> getInvitesToGroups(
    Future Function(InviteToGroupNotification) handleAcceptNotification,
    Future Function(InviteToGroupNotification) handleDeniedNotification,
  ) async {
    var result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "core/profiles/notifications",
      expectedCode: 200,
    );

    try {
      var notifications = result.map((json) {
        var {
          "title": title,
          "group_name": groupName,
          "group_id": groupId,
          "invitor_id": senderId,
          "code": code,
        } = json;

        return InviteToGroupNotification(
          groupName,
          title,
          (notification) async => await handleAcceptNotification(
              notification as InviteToGroupNotification),
          (notification) async => await handleDeniedNotification(
              notification as InviteToGroupNotification),
          code,
          groupId,
          senderId,
        );
      }).toList();

      return List<InviteToGroupNotification>.from(notifications);
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
