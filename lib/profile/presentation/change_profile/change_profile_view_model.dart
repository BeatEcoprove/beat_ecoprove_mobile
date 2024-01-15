import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/profile/contracts/promote_profile_request.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/delete_profile_use_case.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/get_nested_profiles_use_case.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/promote_profile_use_case.dart';
import 'package:go_router/go_router.dart';

class ChangeProfileViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final GetNestedProfilesUseCase _getNestedProfilesUseCase;
  final DeleteProfileUseCase _deleteProfileUseCase;
  final PromoteProfileUseCase _promoteProfileUseCase;
  final GoRouter _navigationRouter;
  late final User _user;
  late ProfilesResult _profilesResult;

  ChangeProfileViewModel(
    this._authProvider,
    this._navigationRouter,
    this._getNestedProfilesUseCase,
    this._deleteProfileUseCase,
    this._promoteProfileUseCase,
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

  Future<void> promoteProfile(String profileId) async {
    try {
      //TODO: CHANGE TO RECEIVE EMAIL E PASSWORD
      await _promoteProfileUseCase.handle(PromoteProfileRequest(
        "new@new.pt",
        "Novoperfil1.",
        profileId,
      ));

      _navigationRouter.push("/show_completed",
          extra: ShowCompletedViewParams(
            text: "Uma conta com este perfil foi criada com sucesso!",
            textButton: "Continuar",
            route: "/changeprofile",
          ));
    } catch (e) {
      print("$e");
    }
  }

  Future<void> deleteProfile(String profileId) async {
    try {
      await _deleteProfileUseCase.handle(profileId);

      _navigationRouter.push("/show_completed",
          extra: ShowCompletedViewParams(
              text: "Perfil foi removido.",
              textButton: "Continuar",
              route: "/changeprofile"));
    } catch (e) {
      print("$e");
    }
  }

  void settings() {
    _navigationRouter.push('/settings');
  }
}
