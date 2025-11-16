import 'package:beat_ecoprove/auth/contracts/profile_result.dart';

class ProfilesResult {
  final List<FinishProfileResult> profiles;

  ProfilesResult(this.profiles);

  factory ProfilesResult.fromJson(List<dynamic> json) {
    return ProfilesResult(
      _convertJsonToFinishProfileResultList(json),
    );
  }

  static List<FinishProfileResult> _convertJsonToFinishProfileResultList(
      List<dynamic> groups) {
    var group = groups.map((item) {
      return FinishProfileResult.fromJson(item);
    }).toList();

    return group;
  }
}
