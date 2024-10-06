import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/medal_item.dart';
import 'package:beat_ecoprove/client/profile/domain/models/medal.dart';

class ProfileViewModel extends ViewModel implements Clone {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;

//TODO: REMOVE AND CREATE A USE CASE AND A SERVICE TO GET USER MEDALS
  final List<Medal> medals = [];
  late final User? _user;

  ProfileViewModel(
    this._authProvider,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
  }

  User? get user => _user;
  List<MedalItem> get medalItems => medals
      .map(
        (medal) => MedalItem(
          icon: medal.icon,
          title: medal.title,
          subTitle: medal.subTitle,
        ),
      )
      .toList();

  void settings() {
    _navigationRouter.push(ProfileRoutes.settings);
  }

  void goPrizes() => _navigationRouter.push(ProfileRoutes.prizes);

  void goChangeProfile() => _navigationRouter.push(ProfileRoutes.changeProfile);

  void goListDetails() {
    _navigationRouter.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Minhas Medalhas",
        numberMaxItemsPage: (double.infinity).ceil(),
        onSearch: (searchTerm, vm) async {
          return medalItems
              .where((medal) =>
                  medal.title.toLowerCase().contains(searchTerm.toLowerCase()))
              .toList();
        },
      ),
    );
  }

  @override
  ProfileViewModel clone() {
    return ProfileViewModel(
      _authProvider,
      _navigationRouter,
    );
  }
}
