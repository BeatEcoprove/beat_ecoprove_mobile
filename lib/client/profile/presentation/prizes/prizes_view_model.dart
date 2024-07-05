import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/advert_item.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class PrizesViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationManager;
  final StaticValuesProvider _valuesProvider;

  late final User? _user;
  final List<AdvertItem> adverts = [];

  PrizesViewModel(
    this._authProvider,
    this._navigationManager,
    this._valuesProvider,
  ) {
    _user = _authProvider.appUser;

    adverts.addAll(_valuesProvider.advertsList);
  }

  User? get user => _user;

  void goTradePoints() => _navigationManager.push(ProfileRoutes.tradepoints);
}
