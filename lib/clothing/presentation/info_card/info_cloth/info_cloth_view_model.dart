import 'package:beat_ecoprove/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoClothViewModel extends ViewModel {
  final NotificationProvider _notificationProvider;
  final MarkClothAsDailyUseUseCase _markClothAsDailyUseUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;

  late bool isInUse = false;

  InfoClothViewModel(
    this._notificationProvider,
    this._markClothAsDailyUseUseCase,
    this._unMarkClothAsDailyUseUseCase,
  );

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
}
