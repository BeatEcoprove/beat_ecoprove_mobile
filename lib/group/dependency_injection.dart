import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension GroupDependencyInjection on DependencyInjection {
  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<AppRouter>();

    locator
        .registerFactory(() => GroupViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => GroupChatViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => GroupChatMembersViewModel(authProvider, router.appRouter));
    locator.registerFactory(
        () => CreateGroupViewModel(authProvider, router.appRouter));
  }

  void addGroup() {
    GetIt locator = DependencyInjection.locator;

    _addViewModels(locator);
  }
}
