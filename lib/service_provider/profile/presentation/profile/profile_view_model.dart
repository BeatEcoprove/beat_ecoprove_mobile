import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class ServiceProviderProfileViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;

  late final User _user;

  ServiceProviderProfileViewModel(
    this._authProvider,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  void settings() {
    _navigationRouter.push(ProfileRoutes.settings);
  }
}
