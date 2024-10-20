import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_clothes_use_case%20.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
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
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_params.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_params.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:beat_ecoprove/group/routes.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:get_it/get_it.dart';

extension GroupDependencyInjection on DependencyInjection {
  void _addUseCases(GetIt locator) {
    var groupService = locator<GroupService>();
    var profileService = locator<ProfileService>();

    locator.registerSingleton(
      RegisterGroupUseCase(groupService),
    );

    locator.registerSingleton(
      UpdateGroupUseCase(groupService),
    );

    locator.registerSingleton(
      GetGroupsUseCase(groupService),
    );

    locator.registerSingleton(
      GetDetailsUseCase(groupService),
    );

    locator.registerSingleton(
      LeaveGroupUseCase(groupService),
    );

    locator.registerSingleton(
      PromoteMemberUseCase(groupService),
    );

    locator.registerSingleton(
      InviteMemberToGroupUseCase(groupService),
    );

    locator.registerSingleton(
      GetByUserNameUseCase(profileService),
    );

    locator.registerSingleton(
      DespromoveMemberUseCase(groupService),
    );
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var notificationProvider = locator<INotificationProvider>();
    var router = locator<INavigationManager>();
    var registerGroupUseCase = locator<RegisterGroupUseCase>();
    var updateGroupUseCase = locator<UpdateGroupUseCase>();
    var getGroupsUseCase = locator<GetGroupsUseCase>();
    var getDetailsUseCase = locator<GetDetailsUseCase>();
    var leaveGroupUseCase = locator<LeaveGroupUseCase>();
    var promoteGroupMemberUseCase = locator<PromoteMemberUseCase>();
    var inviteMemberToGroupUseCase = locator<InviteMemberToGroupUseCase>();
    var despromoveGroupMemberUseCase = locator<DespromoveMemberUseCase>();
    var getClothesUseCase = locator<GetClothesUseCase>();
    var notificationManager = locator<NotificationManager>();

    locator.registerFactory(
      () => GroupViewModel(
        notificationProvider,
        authProvider,
        getGroupsUseCase,
        router,
        notificationManager,
        locator<ProfileService>(),
        locator<GroupService>(),
      ),
    );

    locator.registerFactory(
      () => GroupChatViewModel(
        notificationProvider,
        authProvider,
        getDetailsUseCase,
        getClothesUseCase,
        router,
        locator<IWCNotifier>(),
        locator<GroupManager>(),
        locator<GroupService>(),
      ),
    );

    locator.registerFactory(
      () => GroupChatMembersViewModel(
        notificationProvider,
        authProvider,
        getDetailsUseCase,
        leaveGroupUseCase,
        promoteGroupMemberUseCase,
        despromoveGroupMemberUseCase,
        inviteMemberToGroupUseCase,
        locator<INavigationManager>(),
        locator<ProfileService>(),
      ),
    );

    locator.registerFactory(
      () => EditGroupViewModel(
        notificationProvider,
        updateGroupUseCase,
        router,
      ),
    );

    locator.registerFactory(
      () => CreateGroupViewModel(
        notificationProvider,
        registerGroupUseCase,
        router,
      ),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactory(
      () => GroupView(
        viewModel: locator<GroupViewModel>(),
      ),
    );

    locator.registerFactory(
      () => CreateGroupView(
        viewModel: locator<CreateGroupViewModel>(),
      ),
    );

    locator.registerFactoryParam<GroupChatMembersView, GroupChatParams, void>(
      (params, _) => GroupChatMembersView(
        viewModel: locator<GroupChatMembersViewModel>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<GroupChatView, GroupItem, void>(
      (params, _) => GroupChatView(
        viewModel: locator<GroupChatViewModel>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<EditGroupView, EditGroupParams, void>(
      (params, _) => EditGroupView(
        viewModel: locator<EditGroupViewModel>(),
        args: params,
      ),
    );
  }

  void addGroup(ApplicationRouter router) {
    GetIt locator = DependencyInjection.locator;

    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);

    router.addRoute(groupRoute);
  }
}
