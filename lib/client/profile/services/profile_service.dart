import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/public_profile_result.dart';
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

  Future<PublicProfilesResult> getProfileDataById(
      List<dynamic> profileIds) async {
    final idsParam = profileIds.join(',');

    return PublicProfilesResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "core/profiles/public?ids=$idsParam",
      expectedCode: 200,
    ));
  }

  Future<ProfilesResult> getAllProfiles(int page, int pageSize,
      {String search = ""}) async {
    var result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "core/profiles",
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
    return AuthResult.fromJson(
      await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/account/profiles/reserve",
        expectedCode: 201,
      ),
    );
  }

  Future<List<InviteToGroupNotification>> getInvitesToGroups(
    Future Function(InviteToGroupNotification) handleAcceptNotification,
    Future Function(InviteToGroupNotification) handleDeniedNotification,
  ) async {
    try {
      var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "messaging/notifications",
        expectedCode: 200,
      );

      if (result is! Map<String, dynamic> || result['data'] == null) {
        return [];
      }

      final List<dynamic> data = result['data'];

      final List<InviteToGroupNotification> invites = data.map((json) {
        final String code = json['id'] as String;
        final Map<String, dynamic> metadata =
            json['metadata'] as Map<String, dynamic>;
        final String title = json['title'] as String? ?? "Group invitation";
        final String body = json['body'] as String;

        final String groupId = metadata['reference_id'] as String;
        final String senderId = metadata['actor_id'] as String;

        return InviteToGroupNotification(
          title,
          body,
          (notification) async => await handleAcceptNotification(
              notification as InviteToGroupNotification),
          (notification) async => await handleDeniedNotification(
              notification as InviteToGroupNotification),
          code,
          groupId,
          senderId,
        );
      }).toList();

      return List<InviteToGroupNotification>.from(invites);
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
