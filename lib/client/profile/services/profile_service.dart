import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/core/providers/notifications/types/invite_group_notification.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/client/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/client/profile/contracts/promote_profile_request.dart';
import 'package:beat_ecoprove/client/profile/contracts/register_profile_request.dart';

class ProfileService {
  final HttpAuthClient _httpClient;

  ProfileService(
    this._httpClient,
  );

  Future<NestedProfilesResult> getNestedProfiles() async {
    return NestedProfilesResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles",
      expectedCode: 200,
    ));
  }

  Future<ProfilesResult> getAllProfiles({String search = ""}) async {
    var result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/all?search=$search",
      expectedCode: 200,
    );

    return ProfilesResult.fromJson(result);
  }

  Future removeNestedProfile(String profileId) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.delete,
      path: "profiles/$profileId",
      expectedCode: 200,
    );
  }

  Future promoteNestedProfile(PromoteProfileRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.put,
      path: "profiles/${request.profileId}/promote",
      body: request,
      expectedCode: 200,
    );
  }

  Future registerProfile(RegisterProfileRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "profiles",
      body: request,
      expectedCode: 200,
    );
  }

  Future<ProfileResult> getByUserName(String request) async {
    return ProfileResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/$request",
      expectedCode: 200,
    ));
  }

  Future<List<InviteToGroupNotification>> getInvitesToGroups(
    Future Function(InviteToGroupNotification) handleAcceptNotification,
    Future Function(InviteToGroupNotification) handleDeniedNotification,
  ) async {
    var result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/notifications",
      expectedCode: 200,
    );

    var notifications = result.map((json) {
      var {
        "title": title,
        "groupId": groupId,
        "invitorId": senderId,
        "code": code,
      } = json;

      return InviteToGroupNotification(
        title,
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
  }
}
