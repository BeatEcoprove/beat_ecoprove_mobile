import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class GroupViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;

  final GoRouter _navigationRouter;
  late final User _user;

  GroupViewModel(
    this._authProvider,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  // Future<String> getGroups() async {
  //   Map<String, String> param = {};

  //   for (var (value as Map<String, String>) in _selectedFilters.values) {
  //     param.addAll(value);
  //   }

  //   for (var filter in _selectedHorizontalFilters) {
  //     param.addAll({filter: 'category'});
  //   }

  //   try {
  //     _groups.clear();
  //     _groups.addAll(await _getClosetUseCase.handle(param));
  //   } catch (e) {
  //     print("$e");
  //   }

  //   return _groups;
  // }
}
