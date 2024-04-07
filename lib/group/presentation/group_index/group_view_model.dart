import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_groups_use_case.dart';
import 'package:beat_ecoprove/group/routes.dart';
import 'package:flutter/material.dart';

class GroupViewModel extends FormViewModel implements Clone {
  final NotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final NotificationManager _notificationManager;
  final GetGroupsUseCase _getGroupsUseCase;
  final INavigationManager _navigationRouter;

  late final User _user;
  late bool isFetching = false;

  final List<GroupItem> _publicGroups = [];
  final List<GroupItem> _privateGroups = [];
  final List<GroupNotification> notifications = [];

  GroupViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getGroupsUseCase,
    this._navigationRouter,
    this._notificationManager,
  ) {
    initializeFields([
      FormFieldValues.search,
    ]);

    _user = _authProvider.appUser;
    notifications.addAll(_notificationManager.notifications);

    _notificationManager.addListener(onNotificationChanged);
  }

  void onNotificationChanged() {
    notifications.clear();
    notifications.addAll(_notificationManager.notifications);
    notifyListeners();
  }

  @override
  void initSync() async {
    await getGroups(3, "");
  }

  @override
  void dispose() {
    _notificationManager.removeListener(onNotificationChanged);
    super.dispose();
  }

  User get user => _user;

  void setSearch(String search) async {
    try {
      setValue<String>(FormFieldValues.search, search);
      await getGroups(3, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  List<GroupItem> get getAllAuthenticatedUserGroups => _privateGroups;
  List<GroupItem> get getAllPublicGroups => _publicGroups;

  Future<void> getGroups(int limit, String? search) async {
    Map<String, String> param = {};
    var searchParam = search ?? getValue(FormFieldValues.search).value ?? "";

    param.addAll({limit.toString(): "pageSize"});

    if (search != null) {}

    param.addAll({searchParam: "search"});

    try {
      isFetching = true;
      notifyListeners();

      _privateGroups.clear();
      _publicGroups.clear();

      var result = await _getGroupsUseCase.handle(param);

      _privateGroups.addAll(result.mine);
      _publicGroups.addAll(result.globals);
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    isFetching = false;
    notifyListeners();
  }

  Future createGroup() async {
    await _navigationRouter.pushAsync(GroupRoutes.create);
    notifyListeners();
  }

  void goToMyGroupsList(List<Widget> Function(List<GroupItem>) func) {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Meus Grupos",
        onSearch: (searchTerm) async {
          await getGroups(100, searchTerm);

          return func(getAllAuthenticatedUserGroups);
        },
      ),
    );
  }

  void goToPublicList(List<Widget> Function(List<GroupItem>) func) {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Grupos Globais",
        onSearch: (searchTerm) async {
          await getGroups(100, searchTerm);

          return func(getAllPublicGroups);
        },
      ),
    );
  }

  void gotToChatGroup(GroupItem item) => _navigationRouter.push(
        GroupRoutes.chat,
        extras: item,
      );

  @override
  clone() {
    return GroupViewModel(
      _notificationProvider,
      _authProvider,
      _getGroupsUseCase,
      _navigationRouter,
      _notificationManager,
    );
  }
}
