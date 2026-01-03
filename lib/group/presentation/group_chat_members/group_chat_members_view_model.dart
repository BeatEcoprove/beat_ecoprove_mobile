import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
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
import 'package:beat_ecoprove/group/contracts/leave_group_request.dart';
import 'package:beat_ecoprove/group/domain/use-cases/despromove_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/invite_member_to_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/leave_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/promote_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/value_objects/user_name.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';
import 'package:beat_ecoprove/home/routes.dart';
import 'package:flutter/material.dart';

class GroupChatMembersViewModel extends FormViewModel<GroupChatParams> {
  final INotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final PromoteMemberUseCase _promoteMemberUseCase;
  final DespromoveMemberUseCase _despromoveMemberUseCase;
  final InviteMemberToGroupUseCase _inviteMemberToGroupUseCase;
  final INavigationManager _navigationManager;
  final ProfileService _profileService;

  late final User? _user;
  late bool _isAdmin = false;
  late bool _isCreator = false;

  GroupChatMembersViewModel(
    this._notificationProvider,
    this._authProvider,
    this._leaveGroupUseCase,
    this._promoteMemberUseCase,
    this._despromoveMemberUseCase,
    this._inviteMemberToGroupUseCase,
    this._navigationManager,
    this._profileService,
  ) {
    _user = _authProvider.appUser;

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
      await getDetails(arg!.groupDetailsResult.id);
    }
  }

  User? get user => _user;

  bool get isMember => arg!.groupDetailsResult.members!.profiles.any(
        (member) => member.id == _user?.id,
      );

  bool get isAdmin => _isAdmin;

  bool get isCreator => _isCreator;

  bool hasPrivilegies() {
    return details.admins!.profiles.map((elem) => elem.id).contains(user?.id);
  }

  bool hasCreatorPrivilegies() {
    return details.creatorId == user?.id;
  }

  void setUserName(String userName) {
    try {
      setValue<String>(
          FormFieldValues.userName, UserNameInvite.create(userName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.userName, e.message);
    }
  }

  GroupDetailsResult get details => arg!.groupDetailsResult;

  Future<void> getDetails(String groupId) async {
    try {
      _isAdmin = hasPrivilegies();
      _isCreator = hasCreatorPrivilegies();
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

  Future<void> leaveGroup(String memberId, String groupId) async {
    try {
      await _leaveGroupUseCase.handle(LeaveGroupRequest(memberId, groupId));

      if (memberId == _user?.id) {
        await _navigationManager.pushAsync(HomeRoutes.home);
      }

      _notificationProvider.showNotification(
        LocaleContext.get().group_group_chat_members_remove,
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

  Future<void> promoteMember(String memberId, String groupId) async {
    try {
      await _promoteMemberUseCase
          .handle(ActionToMemberOfGroupRequest(memberId, groupId, "moderator"));

      _notificationProvider.showNotification(
        LocaleContext.get().group_group_chat_members_promoted,
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

  Future<void> despromoveMember(String memberId, String groupId) async {
    try {
      await _despromoveMemberUseCase
          .handle(ActionToMemberOfGroupRequest(memberId, groupId, "member"));

      _notificationProvider.showNotification(
        LocaleContext.get().group_group_chat_members_demoted,
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

  Future<void> inviteToGroup(String groupId, String userId) async {
    try {
      await _inviteMemberToGroupUseCase.handle(
        InviteMemberRequest(
          userId,
          groupId,
        ),
      );

      _notificationProvider.showNotification(
        LocaleContext.get().group_group_chat_members_invited,
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

    _navigationManager.pop();
    notifyListeners();
  }

  void navigateSearchUsers(BuildContext context) {
    _navigationManager.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: LocaleContext.get().group_group_chat_members_invite,
        numberMaxItemsPage:
            (MediaQuery.sizeOf(context).height.ceil() / 70).ceil() + 2,
        onSearchPagination: (searchTerm, vm, page, pageSize) async {
          var profiles = await _profileService.getAllProfiles(
            page,
            pageSize,
            search: searchTerm,
          );

          return profiles.profiles
              .where((element) => !arg!.groupDetailsResult.members!.profiles
                  .any((member) => member.id == element.id))
              .map(
            (profile) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: CompactListItemRoot(
                  click: () async => await inviteToGroup(
                      arg!.groupDetailsResult.id, profile.id),
                  items: [
                    ImageTitleSubtitleHeader(
                      widget: PresentImage(
                        path: ServerImage(profile.avatarUrl),
                      ),
                      title: profile.username,
                      subTitle:
                          "${LocaleContext.get().group_group_chat_members_level} ${profile.level.toString()}",
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
