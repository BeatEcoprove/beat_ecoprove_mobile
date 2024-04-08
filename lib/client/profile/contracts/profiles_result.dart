import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';

class ProfilesResult {
  final List<ProfileResult> profiles;

  ProfilesResult(this.profiles);

  factory ProfilesResult.fromJson(Map<String, dynamic> json) {
    return ProfilesResult(
      _convertJsonToProfileResultList(json['users']),
    );
  }

  static List<ProfileResult> _convertJsonToProfileResultList(
      List<dynamic> groups) {
    var group = groups.map((item) {
      return ProfileResult.fromJson(item);
    }).toList();

    return group;
  }
}

class NestedProfilesResult {
  final ProfileResult mainProfile;
  final List<ProfileResult> nestedProfiles;

  const NestedProfilesResult(this.mainProfile, this.nestedProfiles);

  factory NestedProfilesResult.empty() {
    return NestedProfilesResult(ProfileResult.empty(), []);
  }

  factory NestedProfilesResult.fromJson(Map<String, dynamic> json) {
    return NestedProfilesResult(
      ProfileResult.fromJson(json['mainProfile']),
      _convertJsonToProfileResultList(json['nestedProfiles']),
    );
  }

  static List<ProfileResult> _convertJsonToProfileResultList(
      List<dynamic> groups) {
    var group = groups.map((item) {
      return ProfileResult.fromJson(item);
    }).toList();

    return group;
  }
}
