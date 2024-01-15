import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:go_router/go_router.dart';

class ChangeProfileViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final GetNestedProfilesUseCase _getNestedProfilesUseCase;
  final GoRouter _navigationRouter;
  late final User _user;
  late ProfilesResult _profilesResult;

  ChangeProfileViewModel(
    this._authProvider,
    this._navigationRouter,
    this._getNestedProfilesUseCase,
  ) {
    _user = _authProvider.appUser;
    _profilesResult = ProfilesResult.empty();
  }

  User get user => _user;
  ProfilesResult get profilesResult => _profilesResult;

  Future<void> getNestedProfiles() async {
    try {
      _profilesResult = await _getNestedProfilesUseCase.handle();
    } catch (e) {
      print("$e");
    }
  }

  void settings() {
    _navigationRouter.push('/settings');
  }
}
