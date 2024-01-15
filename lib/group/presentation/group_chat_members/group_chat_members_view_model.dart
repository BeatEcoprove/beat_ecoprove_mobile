import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:go_router/go_router.dart';

class GroupChatMembersViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final GetDetailsUseCase _getDetailsUseCase;
  final GoRouter _navigationRouter;
  late final User _user;
  late GroupDetailsResult _groupDetailsResult;

  GroupChatMembersViewModel(
    this._authProvider,
    this._navigationRouter,
    this._getDetailsUseCase,
  ) {
    _user = _authProvider.appUser;
    _groupDetailsResult = GroupDetailsResult.empty();
  }

  GroupDetailsResult get details => _groupDetailsResult;

  Future<void> getDetails(String groupId) async {
    try {
      _groupDetailsResult = await _getDetailsUseCase.handle(groupId);
    } catch (e) {
      print("$e");
    }
  }

  User get user => _user;
}
