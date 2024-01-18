import 'package:beat_ecoprove/clothing/services/action_service.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class HomeViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final ClosetService _closetService;
  final ActionService _actionService;
  late final User _user;

  HomeViewModel(this._authProvider, this._closetService, this._actionService) {
    _user = _authProvider.appUser;

    // Get all colors and brands at hand
    _closetService.getAllColors();
    _closetService.getAllBrands();
    _actionService.getAllServices();
  }

  User get user => _user;
}
