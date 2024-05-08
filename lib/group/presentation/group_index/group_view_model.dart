import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/notifications/types/invite_group_notification.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/contracts/accept_member_request.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_groups_use_case.dart';
import 'package:beat_ecoprove/group/routes.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:flutter/material.dart';

class GroupViewModel extends FormViewModel implements Clone {
  final INotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final NotificationManager _notificationManager;
  final GetGroupsUseCase _getGroupsUseCase;
  final INavigationManager _navigationRouter;
  final ProfileService _profileService;
  final GroupService _groupService;

  late final User _user;
  late bool isFetching = false;
  static const int numGroupsToShow = 3;

  final List<GroupItem> publicGroups = [];
  final List<GroupItem> privateGroups = [];
  final List<GroupNotification> notifications = [];

  GroupViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getGroupsUseCase,
    this._navigationRouter,
    this._notificationManager,
    this._profileService,
    this._groupService,
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
    await refetch();
    await getInviteNotifications();
  }

  Future refetch() async {
    await getGroups(numGroupsToShow, null);
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

      await getGroups(3, null);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  Future<void> getInviteNotifications() async {
    try {
      var result = await _profileService.getInvitesToGroups(
        _handleAccept,
        _handleDenied,
      );

      notifications.clear();
      notifications.addAll(result);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future _handleAccept(InviteToGroupNotification notification) async {
    try {
      await _groupService.acceptMember(AcceptMemberOnGroupRequest(
        notification.groupId,
        notification.code,
      ));

      notifications.remove(notification);

      _notificationProvider.showNotification(
        "Entrou no grupo!",
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    await refetch();
  }

  Future _handleDenied(InviteToGroupNotification notification) async {
    try {
      await _groupService.deniedMember(AcceptMemberOnGroupRequest(
        notification.groupId,
        notification.code,
      ));

      notifications.remove(notification);

      _notificationProvider.showNotification(
        "Cancelou o convite!",
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    await refetch();
  }

  Future<void> getGroups(int limit, String? search) async {
    Map<String, String> param = {};
    var searchParam = getValue(FormFieldValues.search).value ?? "";

    param.addAll({limit.toString(): "pageSize"});

    if (search != null) {}

    param.addAll({searchParam: "search"});

    try {
      isFetching = true;

      privateGroups.clear();
      publicGroups.clear();

      var result = await _getGroupsUseCase.handle(param);

      privateGroups.addAll(result.mine);
      publicGroups.addAll(result.globals);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    isFetching = false;
    notifyListeners();
  }

  Future createGroup() async {
    await _navigationRouter.pushAsync(GroupRoutes.create);

    await refetch();
  }

  void goToMyGroupsList(List<Widget> Function(List<GroupItem>) func) {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Meus Grupos",
        onSearch: (searchTerm, vm) async {
          await getGroups(100, searchTerm);

          return func(privateGroups);
        },
      ),
    );
  }

  void goToPublicList(List<Widget> Function(List<GroupItem>) func) {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Grupos Globais",
        onSearch: (searchTerm, vm) async {
          await getGroups(100, searchTerm);

          return func(publicGroups);
        },
      ),
    );
  }

  Future gotToChatGroup(GroupItem item) async {
    await _navigationRouter.pushAsync(
      GroupRoutes.chat,
      extras: item,
    );
    await refetch();
  }

  @override
  clone() {
    var clone = GroupViewModel(
      _notificationProvider,
      _authProvider,
      _getGroupsUseCase,
      _navigationRouter,
      _notificationManager,
      _profileService,
      _groupService,
    );

    clone.publicGroups.addAll(publicGroups);
    clone.privateGroups.addAll(privateGroups);

    return clone;
  }
}
