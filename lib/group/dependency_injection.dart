import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/auth/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_groups_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/leave_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/promote_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/register_group_use_case.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension GroupDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => GroupService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var groupService = locator<GroupService>();

    locator.registerSingleton(RegisterGroupUseCase(groupService));
    locator.registerSingleton(GetGroupsUseCase(groupService));
    locator.registerSingleton(GetDetailsUseCase(groupService));
    locator.registerSingleton(LeaveGroupUseCase(groupService));
    locator.registerSingleton(PromoteMemberUseCase(groupService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var notificationProvider = locator<NotificationProvider>();
    var router = locator<AppRouter>();
    var registerGroupUseCase = locator<RegisterGroupUseCase>();
    var getGroupsUseCase = locator<GetGroupsUseCase>();
    var getDetailsUseCase = locator<GetDetailsUseCase>();
    var leaveGroupUseCase = locator<LeaveGroupUseCase>();
    var promoteGroupMemberUseCase = locator<PromoteMemberUseCase>();

    locator.registerFactory(() => GroupViewModel(
          authProvider,
          getGroupsUseCase,
        ));
    locator.registerFactory(
        () => GroupChatViewModel(authProvider, router.appRouter));
    locator.registerFactory(() => GroupChatMembersViewModel(
          authProvider,
          getDetailsUseCase,
          leaveGroupUseCase,
          promoteGroupMemberUseCase,
        ));
    locator.registerFactory(() => CreateGroupViewModel(
          notificationProvider,
          registerGroupUseCase,
        ));
  }

  void addGroup() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
