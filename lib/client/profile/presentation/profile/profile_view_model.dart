import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/medal_item.dart';
import 'package:beat_ecoprove/client/profile/domain/models/medal.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ViewModel {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;

  final List<Medal> medals = [
    Medal(
      const Icon(
        Icons.military_tech_rounded,
        color: Colors.amber,
        size: 54,
      ),
      "Campeão I",
      "Ser o primeiro 1 vez no grupo de amigos",
    ),
    Medal(
      const Icon(
        Icons.military_tech_rounded,
        color: Colors.blue,
        size: 54,
      ),
      "Socializador I",
      "Convidou 1 amigo",
    ),
    Medal(
      const Icon(
        Icons.military_tech_rounded,
        color: AppColor.darkGreen,
        size: 54,
      ),
      "Sustentável",
      "Ter 5+ peças com eco-Score acima de 30",
    )
  ];
  late final User _user;

  ProfileViewModel(
    this._authProvider,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
  }

  User get user => _user;
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
    _navigationRouter.push('/settings');
  }

  void goPrizes() => _navigationRouter.push("/prizes");

  void goChangeProfile() => _navigationRouter.push("/changeprofile");

  void goListDetails() {
    _navigationRouter.push(
      "/list_details",
      extras: ListDetailsViewParams(
        title: "Minhas Medalhas",
        onSearch: (searchTerm) async {
          return medalItems
              .where((medal) =>
                  medal.title.toLowerCase().contains(searchTerm.toLowerCase()))
              .toList();
        },
      ),
    );
  }
}
