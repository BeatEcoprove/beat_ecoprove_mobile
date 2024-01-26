import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class ProfileViewModel extends ViewModel {
  final LevelUpProvider _levelUpProvider;
  final AuthenticationProvider _authProvider;
  final GoRouter _navigationRouter;
  late final User _user;

  ProfileViewModel(
      this._levelUpProvider, this._authProvider, this._navigationRouter) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  void settings() {
    _navigationRouter.push('/settings');
  }

  void levelUp() {
    _levelUpProvider.showLevelUpNotification();
  }
}
