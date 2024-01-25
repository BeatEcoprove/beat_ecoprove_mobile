import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_groups_use_case.dart';
import 'package:go_router/go_router.dart';

class GroupViewModel extends ViewModel {
  final NotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final GetGroupsUseCase _getGroupsUseCase;
  final GoRouter _navigationRouter;
  late final User _user;

  final List<GroupItem> _publicGroups = [];
  final List<GroupItem> _privateGroups = [];

  GroupViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getGroupsUseCase,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  List<GroupItem> get getAllAuthenticatedUserGroups => _privateGroups;
  List<GroupItem> get getAllPublicGroups => _publicGroups;

  Future<void> getGroups() async {
    try {
      _privateGroups.clear();
      _publicGroups.clear();

      var result = await _getGroupsUseCase.handle();

      _privateGroups.addAll(result.mine);
      _publicGroups.addAll(result.globals);
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }
    return;
  }

  Future createGroup() async {
    await _navigationRouter.push('/create');
    notifyListeners();
  }
}
