import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/leave_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/promote_group_member_use_case.dart';

class GroupChatMembersViewModel extends ViewModel {
  final NotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final GetDetailsUseCase _getDetailsUseCase;
  final LeaveGroupUseCase _leaveGroupUseCase;
  final PromoteMemberUseCase _promoteMemberUseCase;
  late final User _user;
  late GroupDetailsResult _groupDetailsResult;

  GroupChatMembersViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getDetailsUseCase,
    this._leaveGroupUseCase,
    this._promoteMemberUseCase,
  ) {
    _user = _authProvider.appUser;
    _groupDetailsResult = GroupDetailsResult.empty();
  }

  User get user => _user;

  GroupDetailsResult get details => _groupDetailsResult;

  Future<void> getDetails(String groupId) async {
    try {
      _groupDetailsResult = await _getDetailsUseCase.handle(groupId);
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }
  }

  Future<void> leaveGroup(String memberId, String groupId) async {
    try {
      await _leaveGroupUseCase
          .handle(ActionToMemberOfGroupRequest(memberId, groupId));
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Foi removido do grupo!",
      type: NotificationTypes.success,
    );
  }

  Future<void> promoteMember(String memberId, String groupId) async {
    try {
      await _promoteMemberUseCase
          .handle(ActionToMemberOfGroupRequest(memberId, groupId));
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Membro foi promovido a Administrador!",
      type: NotificationTypes.success,
    );
  }
}
