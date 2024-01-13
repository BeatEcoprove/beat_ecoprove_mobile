import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class ChangeProfileViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final GoRouter _navigationRouter;
  late final User _user;

  ChangeProfileViewModel(this._authProvider, this._navigationRouter) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  void settings() {
    _navigationRouter.push('/settings');
  }
}
