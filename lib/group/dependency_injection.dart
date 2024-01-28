import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/domain/use-cases/despromove_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_details_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_groups_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/get_by_user_name_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/invite_member_to_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/leave_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/promote_group_member_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/register_group_use_case.dart';
import 'package:beat_ecoprove/group/domain/use-cases/update_group_use_case.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:beat_ecoprove/profile/services/profile_service.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension GroupDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => GroupService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var groupService = locator<GroupService>();
    var profileService = locator<ProfileService>();

    locator.registerSingleton(RegisterGroupUseCase(groupService));
    locator.registerSingleton(UpdateGroupUseCase(groupService));
    locator.registerSingleton(GetGroupsUseCase(groupService));
    locator.registerSingleton(GetDetailsUseCase(groupService));
    locator.registerSingleton(LeaveGroupUseCase(groupService));
    locator.registerSingleton(PromoteMemberUseCase(groupService));
    locator.registerSingleton(InviteMemberToGroupUseCase(groupService));
    locator.registerSingleton(GetByUserNameUseCase(profileService));
    locator.registerSingleton(DespromoveMemberUseCase(groupService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var notificationProvider = locator<NotificationProvider>();
    var router = locator<AppRouter>();
    var registerGroupUseCase = locator<RegisterGroupUseCase>();
    var updateGroupUseCase = locator<UpdateGroupUseCase>();
    var getGroupsUseCase = locator<GetGroupsUseCase>();
    var getDetailsUseCase = locator<GetDetailsUseCase>();
    var leaveGroupUseCase = locator<LeaveGroupUseCase>();
    var promoteGroupMemberUseCase = locator<PromoteMemberUseCase>();
    var inviteMemberToGroupUseCase = locator<InviteMemberToGroupUseCase>();
    var getByUserName = locator<GetByUserNameUseCase>();
    var despromoveGroupMemberUseCase = locator<DespromoveMemberUseCase>();
    var navigator = locator<AppRouter>();
    var notificationManager = locator<NotificationManager>();

    locator.registerFactory(() => GroupViewModel(
          notificationProvider,
          authProvider,
          getGroupsUseCase,
          navigator.appRouter,
          notificationManager,
        ));

    locator.registerFactory(() => GroupChatViewModel(
          notificationProvider,
          authProvider,
          getDetailsUseCase,
          router.appRouter,
        ));
    locator.registerFactory(() => GroupChatMembersViewModel(
          notificationProvider,
          authProvider,
          getDetailsUseCase,
          leaveGroupUseCase,
          promoteGroupMemberUseCase,
          despromoveGroupMemberUseCase,
          inviteMemberToGroupUseCase,
          getByUserName,
        ));
    locator.registerFactory(() => EditGroupViewModel(
          notificationProvider,
          updateGroupUseCase,
          navigator.appRouter,
        ));
    locator.registerFactory(() => CreateGroupViewModel(
          notificationProvider,
          registerGroupUseCase,
          navigator.appRouter,
        ));
  }

  void addGroup() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
