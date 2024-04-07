import 'dart:async';

import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_parms.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoClothViewModel extends ViewModel<InfoClothParams> implements Clone {
  final NotificationProvider _notificationProvider;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final ActionService _actionService;

  late bool isInUse = false;
  late bool disableButton = false;

  InfoClothViewModel(
    this._notificationProvider,
    this._markClothAsDailyUseUseCase,
    this._unMarkClothAsDailyUseUseCase,
    this._actionService,
  );

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
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
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
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Estado da/s peça/s alterado!",
      type: NotificationTypes.success,
    );
  }

  Future _unMarkClothAsDailyUse(List<String> idsCloth) async {
    try {
      await _unMarkClothAsDailyUseUseCase.handle(idsCloth);
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Estado da/s peça/s alterado!",
      type: NotificationTypes.success,
    );
  }

  @override
  clone() {
    return InfoClothViewModel(
      _notificationProvider,
      _markClothAsDailyUseUseCase,
      _unMarkClothAsDailyUseUseCase,
      _actionService,
    );
  }
}
