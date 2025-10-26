class AccountResult {
  final String userId;
  final String email;
  final String profileId;
  final List<String> profilesIds;
  final String role;

  AccountResult(
      this.userId, this.email, this.profileId, this.profilesIds, this.role);

  factory AccountResult.fromJson(Map<String, dynamic> json) {
    return AccountResult(
      json['user_id'],
      json['email'],
      json['profile_id'],
      List<String>.from(json['profiles_ids']),
      json['role'],
    );
  }
}
