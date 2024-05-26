import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_widget_view/list_widget_params.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/services/datetime_service.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advert_header.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advet_card_root.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/advert_result.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/remove_advert_request.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_params.dart';
import 'package:beat_ecoprove/service_provider/profile/routes.dart';
import 'package:beat_ecoprove/service_provider/profile/services/adverts_service.dart';
import 'package:flutter/material.dart';

class ServiceProviderProfileViewModel extends ViewModel implements Clone {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;
  final AdvertsService _advertsService;
  final INotificationProvider _notificationProvider;

  late final User? user;

  ServiceProviderProfileViewModel(
    this._authProvider,
    this._navigationRouter,
    this._advertsService,
    this._notificationProvider,
  ) {
    user = _authProvider.appUser;
  }

  void settings() {
    _navigationRouter.push(ProfileRoutes.settings);
  }

  List<OptionItem> _options(String advertId) {
    return [
      OptionItem(
        name: "Remover Anúncio",
        action: () async => await _removeAdvert(advertId),
      ),
    ];
  }

  Future _removeAdvert(String advertId) async {
    try {
      await _advertsService.removeAdvert(RemoveAdvertRequest(advertId));
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future goToCreatePrize(String type, int prize) async {
    await _navigationRouter.pushAsync(
      ServiceProviderProfileRoutes.registerAdvert,
      extras: CreatePrizeParams(
        type: type,
        price: prize,
      ),
    );
    notifyListeners();
  }

  void advertsPage() {
    _navigationRouter.push(
      CoreRoutes.listWidget,
      extras: ListWidgetViewParams(
        title: "",
        noResultsText: "Não existem anúncios!",
        getContent: (vm) async {
          List<AdvertResult> adverts = [];
          try {
            adverts = await _advertsService.getActiveAdverts();
          } catch (e) {
            rethrow;
          }

          return adverts.map(
            (advert) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: AdvertCardRoot(
                  items: [
                    AdvertHeader(
                      isCircular: true,
                      widget: PresentImage(
                        path: ServerImage(advert.advertPicture),
                      ),
                      title: advert.title,
                      subTitle:
                          '${DatetimeService.formatDateCompact(advert.beginIn)} - ${DatetimeService.formatDateCompact(advert.endIn)}',
                      contentText: advert.contentText,
                      contentSubText: advert.contentSubText,
                      options: _options(advert.advertId),
                    ),
                  ],
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }

  void createPrize(List<ServiceTemplate> items) {
    _navigationRouter.push(
      CoreRoutes.selectService,
      extras: ServiceParams(
        noResultsText: "Não tem Pontos Sustentáveis para nenhum prémio!",
        services: {
          "": items,
        },
      ),
    );
  }

  @override
  ServiceProviderProfileViewModel clone() {
    return ServiceProviderProfileViewModel(
      _authProvider,
      _navigationRouter,
      _advertsService,
      _notificationProvider,
    );
  }
}
