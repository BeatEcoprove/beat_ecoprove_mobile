import 'dart:async';

import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/get_current_maintenance_action_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/requests/history_action_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/models/history_item.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_cloth_history_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_cloth_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_parms.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/presentation/qr_code/qr_code_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/services/datetime_service.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/text_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:flutter/material.dart';

class InfoClothViewModel extends ViewModel<InfoClothParams> implements Clone {
  final INavigationManager _navigationManager;
  final INotificationProvider _notificationProvider;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final GetClothHistoryUseCase _getClothHistoryUseCase;
  final GetClothByIdUseCase _getClothByIdUseCase;
  final ActionService _actionService;
  final AuthenticationProvider _authenticationProvider;

  late bool isInUse = false;
  late bool disableButton = false;
  late bool isLoading = true;
  late CardItem cardItem = CardItem(
    id: "",
    title: "",
    child: ServerConfig.defaultImage,
  );
  final List<HistoryItem> clothHistories = [];

  InfoClothViewModel(
    this._navigationManager,
    this._notificationProvider,
    this._markClothAsDailyUseUseCase,
    this._unMarkClothAsDailyUseUseCase,
    this._getClothHistoryUseCase,
    this._getClothByIdUseCase,
    this._actionService,
    this._authenticationProvider,
  );

  @override
  void initSync() async {
    isLoading = true;
    notifyListeners();

    if (arg == null) {
      _notificationProvider.showNotification(
        LocaleContext.get().client_clothing_info_card_cloth_garment_not_found,
        type: NotificationTypes.success,
      );
      _navigationManager.pop();
      return;
    }
    cardItem = await _getClothByIdUseCase.handle(arg!.index);
    await isClothOnMaintenance(arg!.index);

    isLoading = false;
    notifyListeners();
  }

  Future isClothOnMaintenance(String clothId) async {
    if (cardItem.clothState == ClothStates.blocked) {
      disableButton = true;
      return;
    }

    try {
      var availableServices =
          await _actionService.getClothAvailableServices(clothId);

      if (availableServices.isNotEmpty) {
        return;
      }

      var currentRunningServices =
          await _actionService.getCurrentServiceActivity(clothId);

      switch (currentRunningServices.status) {
        case ServiceStates.finish:
          disableButton = false;
          return;
        case ServiceStates.running:
          disableButton = true;
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
        LocaleContext.get()
            .client_clothing_info_card_cloth_garment_status_updated,
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
        LocaleContext.get()
            .client_clothing_info_card_cloth_garment_status_updated,
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

  Future<void> getHistory(int page, int pageSize, String search) async {
    Map<String, String> param = {};

    param.addAll({search: "search"});

    try {
      clothHistories.clear();

      var result = await _getClothHistoryUseCase.handle(
        HistoryActionRequest(
          arg!.index,
          page: page,
          pageSize: pageSize,
          params: param,
        ),
      );

      clothHistories.addAll(result);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  List<Widget> _renderCards(List<HistoryItem> clothHistory) {
    return clothHistory
        .map(
          (e) => Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: CompactListItemRoot(
              items: [
                TextHeader(
                  title: e.actionName,
                  subTitle: DatetimeService.formatDate(e.endedAt),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  void getClothHistory(BuildContext context) {
    _navigationManager.push(
      CoreRoutes.listDetails,
      extras: ListDetailsViewParams(
        title:
            LocaleContext.get().client_clothing_info_card_cloth_garment_history,
        numberMaxItemsPage:
            (MediaQuery.sizeOf(context).height.ceil() / 70).ceil() + 2,
        hasSearchBar: false,
        onSearchPagination: (searchTerm, vm, page, pageSize) async {
          await getHistory(page, pageSize, searchTerm);

          return _renderCards(clothHistories);
        },
      ),
    );
  }

  void goToQRCodePage() {
    var clothUrl =
        "orders?ownerId=${_authenticationProvider.appUser?.id}&clothId=${arg?.index ?? ""}";

    _navigationManager.push(CoreRoutes.qrCode,
        extras: QRCodeParams(
          data: clothUrl,
          textButton:
              LocaleContext.get().client_clothing_info_card_cloth_stores,
          action: () => {},
        ));
  }

  @override
  clone() {
    return InfoClothViewModel(
      _navigationManager,
      _notificationProvider,
      _markClothAsDailyUseUseCase,
      _unMarkClothAsDailyUseUseCase,
      _getClothHistoryUseCase,
      _getClothByIdUseCase,
      _actionService,
      _authenticationProvider,
    );
  }
}
