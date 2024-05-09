import 'dart:async';

import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history_action_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_parms.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/client/clothing/services/cloth_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/text_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoClothViewModel extends ViewModel<InfoClothParams> implements Clone {
  final AuthenticationProvider _authenticationProvider;
  final INavigationManager _navigationManager;
  final INotificationProvider _notificationProvider;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final ActionService _actionService;
  final ClothService _clothService;

  late bool isInUse = false;
  late bool disableButton = false;

  late User? _user;

  InfoClothViewModel(
    this._authenticationProvider,
    this._navigationManager,
    this._notificationProvider,
    this._markClothAsDailyUseUseCase,
    this._unMarkClothAsDailyUseUseCase,
    this._actionService,
    this._clothService,
  ) {
    _user = _authenticationProvider.appUser;
  }

  @override
  void initSync() async {
    if (arg != null) {
      await isClothOnMaintenance(arg!.card.id);
      notifyListeners();
    }
  }

  Future isClothOnMaintenance(String clothId) async {
    try {
      var availableServices =
          await _actionService.getClothAvailableServices(clothId);

      if (availableServices.isNotEmpty) {
        return;
      }

      var currentRunningServices =
          await _actionService.getCurrentServiceActivity(clothId);

      if (currentRunningServices.status == "Finished") {
        disableButton = false;
        return;
      }
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    disableButton = true;
  }

  Future setClothState(String idsCloth, CardItem card) async {
    isInUse
        ? _unMarkClothAsDailyUse([idsCloth])
        : _markClothAsDailyUse([idsCloth]);

    isInUse = !isInUse;
    card.clothState = isInUse ? ClothStates.inUse : ClothStates.idle;
    notifyListeners();
  }

  Future _markClothAsDailyUse(List<String> idsCloth) async {
    try {
      await _markClothAsDailyUseUseCase.handle(idsCloth);

      _notificationProvider.showNotification(
        "Estado da/s peça/s alterado!",
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future _unMarkClothAsDailyUse(List<String> idsCloth) async {
    try {
      await _unMarkClothAsDailyUseUseCase.handle(idsCloth);

      _notificationProvider.showNotification(
        "Estado da/s peça/s alterado!",
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void getClothHistory() {
    _navigationManager.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title: "Histórico da Peça",
        onSearch: (searchTerm, vm) async {
          var actionsHistory = await _clothService.getClothHistory(
            HistoryActionRequest(
              _user!.id,
              arg!.card.id,
            ),
          );

          return actionsHistory
              .where((clothHistory) => clothHistory.actionName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()))
              .map(
            (clothHistory) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: CompactListItemRoot(
                  items: [
                    TextHeader(
                      title: clothHistory.actionName,
                      subTitle: DateFormat('yyyy-MM-dd HH:mm')
                          .format(clothHistory.date),
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

  @override
  clone() {
    return InfoClothViewModel(
      _authenticationProvider,
      _navigationManager,
      _notificationProvider,
      _markClothAsDailyUseUseCase,
      _unMarkClothAsDailyUseUseCase,
      _actionService,
      _clothService,
    );
  }
}
