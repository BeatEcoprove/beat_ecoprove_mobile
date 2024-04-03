import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class PrizesViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationManager;
  late final User _user;

  PrizesViewModel(
    this._authProvider,
    this._navigationManager,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  void goTradePoints() => _navigationManager.push(ProfileRoutes.tradepoints);
}
