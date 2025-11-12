import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/profile_result.dart';

class RefreshProfile {
  final AuthResult tokens;
  final FinishProfileResult profile;

  RefreshProfile({
    required this.tokens,
    required this.profile,
  });
}
