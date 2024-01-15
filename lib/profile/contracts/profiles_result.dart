import 'package:beat_ecoprove/profile/contracts/profile_result.dart';

class ProfilesResult {
  final ProfileResult mainProfile;
  final List<ProfileResult> nestedProfiles;

  const ProfilesResult(this.mainProfile, this.nestedProfiles);

  factory ProfilesResult.empty() {
    return ProfilesResult(ProfileResult.empty(), []);
  }

  factory ProfilesResult.fromJson(Map<String, dynamic> json) {
    return ProfilesResult(
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
