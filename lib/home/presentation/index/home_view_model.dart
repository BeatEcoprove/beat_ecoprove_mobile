import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class HomeViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  late final User _user;

  HomeViewModel(this._authProvider) {
    _user = _authProvider.appUser;
  }

  User get user => _user;
}
