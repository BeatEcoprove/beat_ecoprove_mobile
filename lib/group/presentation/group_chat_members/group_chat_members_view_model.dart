import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/contracts/invite_member_request.dart';
import 'package:beat_ecoprove/group/domain/use-cases/despromove_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/invite_member_to_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/leave_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/promote_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/value_objects/user_name.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';
import 'package:flutter/material.dart';

class GroupChatMembersViewModel extends FormViewModel<GroupChatParams> {
  final INotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final GetDetailsUseCase _getDetailsUseCase;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final PromoteMemberUseCase _promoteMemberUseCase;
  final DespromoveMemberUseCase _despromoveMemberUseCase;
  final InviteMemberToGroupUseCase _inviteMemberToGroupUseCase;
  final INavigationManager _navigationManager;
  final ProfileService _profileService;

  late final User _user;
  late GroupDetailsResult _groupDetailsResult;
  late bool _isAdmin;
  late bool _isCreator;

  GroupChatMembersViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getDetailsUseCase,
    this._leaveGroupUseCase,
    this._promoteMemberUseCase,
    this._despromoveMemberUseCase,
    this._inviteMemberToGroupUseCase,
    this._navigationManager,
    this._profileService,
  ) {
    _user = _authProvider.appUser;
    _groupDetailsResult = GroupDetailsResult.empty();

    initializeFields([
      FormFieldValues.userName,
    ]);
  }

  @override
  void initSync() async {
    await refetch();
  }

  Future refetch() async {
    if (arg != null) {
      await getDetails(arg!.groupId);
    }
  }

  User get user => _user;

  bool get isMember => _groupDetailsResult.members.any(
        (member) => member.id == _user.id,
      );

  bool get isAdmin => _isAdmin;

  bool get isCreator => _isCreator;

  bool hasPrivilegies() {
    return details.admins.map((elem) => elem.id).contains(user.id);
  }

  bool hasCreatorPrivilegies() {
    return details.creator.id == user.id;
  }

  void setUserName(String userName) {
    try {
      setValue<String>(
          FormFieldValues.userName, UserNameInvite.create(userName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.userName, e.message);
    }
  }

  GroupDetailsResult get details => _groupDetailsResult;

  Future<void> getDetails(String groupId) async {
    try {
      _groupDetailsResult = await _getDetailsUseCase.handle(groupId);
      _isAdmin = hasPrivilegies();
      _isCreator = hasCreatorPrivilegies();
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

    notifyListeners();
  }

  Future<void> leaveGroup(String memberId, String groupId) async {
    try {
      await _leaveGroupUseCase
          .handle(ActionToMemberOfGroupRequest(memberId, groupId));

      _notificationProvider.showNotification(
        "Foi removido do grupo!",
        type: NotificationTypes.success,
      );
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

    await refetch();
  }

  Future<void> promoteMember(String memberId, String groupId) async {
    try {
      await _promoteMemberUseCase
          .handle(ActionToMemberOfGroupRequest(memberId, groupId));

      _notificationProvider.showNotification(
        "Membro foi promovido a Administrador!",
        type: NotificationTypes.success,
      );
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

    await refetch();
  }

  Future<void> despromoveMember(String memberId, String groupId) async {
    try {
      await _despromoveMemberUseCase
          .handle(ActionToMemberOfGroupRequest(memberId, groupId));

      _notificationProvider.showNotification(
        "Administrador foi despromovido!",
        type: NotificationTypes.success,
      );
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

    await refetch();
  }

  Future<void> inviteToGroup(String groupId, String userId) async {
    try {
      try {
        await _inviteMemberToGroupUseCase.handle(
          InviteMemberRequest(
            userId,
            groupId,
          ),
        );

        _notificationProvider.showNotification(
          "Utilizador foi convidado!",
          type: NotificationTypes.success,
        );
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

    _navigationManager.pop();
    notifyListeners();
  }

  void navigateSearchUsers() {
    _navigationManager.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Convide um Utilizador",
        onSearch: (searchTerm, vm) async {
          var profiles = await _profileService.getAllProfiles();

          return profiles.profiles
              .where((element) => !_groupDetailsResult.members
                  .any((member) => member.id == element.id))
              .where((profile) => profile.username
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()))
              .map(
            (profile) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: CompactListItemRoot(
                  click: () async =>
                      await inviteToGroup(arg!.groupId, profile.id),
                  items: [
                    ImageTitleSubtitleHeader(
                      widget: PresentImage(
                        path: ServerImage(profile.avatarUrl),
                      ),
                      title: profile.username,
                      subTitle: "Level ${profile.level.toString()}",
                    ),
                  ],
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }
}
