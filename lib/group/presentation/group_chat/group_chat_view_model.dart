import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view.dart';
import 'package:go_router/go_router.dart';

class GroupChatViewModel extends ViewModel {
  final NotificationProvider _notificationProvider;

  final AuthenticationProvider _authProvider;
  final GetDetailsUseCase _getDetailsUseCase;
  final GoRouter _navigationRouter;
  late bool isLoading = false;
  late final User _user;

  GroupChatViewModel(
    this._notificationProvider,
    this._authProvider,
    this._getDetailsUseCase,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;

  Future updateGroup(String groupId) async {
    try {
      isLoading = true;
      var groupDetails = await _getDetailsUseCase.handle(groupId);

      List<String> adminsIds = groupDetails.admins.map((e) => e.id).toList();

      adminsIds.add(groupDetails.creator.id);

      await _navigationRouter.push(
        "/update",
        extra: UpdateGroupParams(
          group: groupDetails,
          adminId: adminsIds,
        ),
      );
    } catch (e) {
      print("$e");

      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }
    isLoading = false;
  }
}
