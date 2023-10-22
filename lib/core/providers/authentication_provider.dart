import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class AuthenticationProvider extends ViewModel {
  late final User? _appUser = null;

  bool get isAuthenticated => _appUser != null;

  void authenticate(String accessToken, String refreshToken) {}

  void logout() {
    _appUser == null;
  }
}
