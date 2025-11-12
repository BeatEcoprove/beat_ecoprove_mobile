class ProfileResult {
  final String userId;
  final String email;
  final String profileId;
  final List<String> profilesIds;
  final String role;

  ProfileResult(
    this.userId,
    this.email,
    this.profileId,
    this.profilesIds,
    this.role,
  );

  factory ProfileResult.empty() {
    return ProfileResult('', '', '', [], "client");
  }

  factory ProfileResult.fromJson(Map<String, dynamic> json) {
    return ProfileResult(
      json['user_id'] ?? '',
      json['email'] ?? '',
      json['profile_id'] ?? '',
      json['profile_ids'] ?? [],
      json['role'] ?? 'client',
    );
  }
}
