import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/contracts/invite_member_request.dart';
import 'package:beat_ecoprove/group/domain/use-cases/despromove_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_by_user_name_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/invite_member_to_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/leave_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/promote_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/value_objects/user_name.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';

class GroupChatMembersViewModel extends FormViewModel<GroupChatParams> {
  final NotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final GetDetailsUseCase _getDetailsUseCase;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final PromoteMemberUseCase _promoteMemberUseCase;
  final DespromoveMemberUseCase _despromoveMemberUseCase;
  final InviteMemberToGroupUseCase _inviteMemberToGroupUseCase;
  final GetByUserNameUseCase _getByUserNamesUseCase;
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
    this._getByUserNamesUseCase,
  ) {
    _user = _authProvider.appUser;
    _groupDetailsResult = GroupDetailsResult.empty();

    initializeFields([
      FormFieldValues.userName,
    ]);
  }

  @override
  void initSync() async {
    if (arg != null) {
      await getDetails(arg!.groupId);
    }
  }

  User get user => _user;

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

    notifyListeners();
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

    notifyListeners();
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

    notifyListeners();
  }

  Future<void> inviteToGroup(String groupId) async {
    String userName = getValue(FormFieldValues.userName).value ?? '';

    try {
      var user = await _getByUserNamesUseCase.handle(userName);

      try {
        await _inviteMemberToGroupUseCase.handle(InviteMemberRequest(
          user.id,
          groupId,
        ));

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
  }
}
