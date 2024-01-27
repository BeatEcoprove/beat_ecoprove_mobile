import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_groups_use_case.dart';
import 'package:go_router/go_router.dart';

class GroupViewModel extends FormViewModel {
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
    initializeFields([
      FormFieldValues.search,
    ]);
  }

  User get user => _user;

  void setSearch(String search) {
    try {
      setValue<String>(FormFieldValues.search, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  List<GroupItem> get getAllAuthenticatedUserGroups => _privateGroups;
  List<GroupItem> get getAllPublicGroups => _publicGroups;

  Future<void> getGroups(int limit) async {
    Map<String, String> param = {};

    param.addAll({limit.toString(): "pageSize"});

    param.addAll({getValue(FormFieldValues.search).value ?? "": "search"});

    try {
      _privateGroups.clear();
      _publicGroups.clear();

      var result = await _getGroupsUseCase.handle(param);

      _privateGroups.addAll(result.mine);
      _publicGroups.addAll(result.globals);
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    return;
  }

  Future createGroup() async {
    await _navigationRouter.push('/create');
    notifyListeners();
  }
}
