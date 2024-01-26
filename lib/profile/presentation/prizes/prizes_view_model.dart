import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class PrizesViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  late final User _user;

  PrizesViewModel(this._authProvider) {
    _user = _authProvider.appUser;
  }

  User get user => _user;
}
