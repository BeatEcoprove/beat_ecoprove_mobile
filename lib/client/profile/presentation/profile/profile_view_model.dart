import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/medal_item.dart';
import 'package:beat_ecoprove/client/profile/domain/models/medal.dart';

class ProfileViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;

//TODO: REMOVE AND CREATE A USE CASE AND A SERVICE TO GET USER MEDALS
  final List<Medal> medals = [];

  ProfileViewModel(
    this._authProvider,
    this._navigationRouter,
  );

  User? get user => _authProvider.appUser;

  List<MedalItem> get medalItems => medals
      .map(
        (medal) => MedalItem(
          icon: medal.icon,
          title: medal.title,
          subTitle: medal.subTitle,
        ),
      )
      .toList();

  Future<void> refresh() async {
    await _authProvider.checkAuth();
    notifyListeners();
  }

  void settings() {
    _navigationRouter.push(ProfileRoutes.settings);
  }

  void goPrizes() => _navigationRouter.push(ProfileRoutes.prizes);

  void goChangeProfile() => _navigationRouter.push(ProfileRoutes.changeProfile);

  void goListDetails() {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: LocaleContext.get().client_profile_profile_my_medals,
        numberMaxItemsPage: 500,
        onSearch: (searchTerm, vm) async {
          return medalItems
              .where((medal) =>
                  medal.title.toLowerCase().contains(searchTerm.toLowerCase()))
              .toList();
        },
      ),
    );
  }
}
