import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/routes.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoBucketViewModel extends ViewModel implements Clone {
  final IBucketInfoManager<String> _bucketInfoManager;
  final INotificationProvider _notificationProvider;
  final RemoveClothFromBucketUseCase _removeClothFromBucketUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final INavigationManager _navigationRouter;

  InfoBucketViewModel(
    this._bucketInfoManager,
    this._notificationProvider,
    this._removeClothFromBucketUseCase,
    this._unMarkClothAsDailyUseUseCase,
    this._navigationRouter,
  );

  void changeCardsSelection(Map<String, List<String>> cards) {
    if (_bucketInfoManager.getAllClothes().contains(cards.keys.first)) {
      _bucketInfoManager.removeCloth(cards.keys.first);
    } else {
      _bucketInfoManager.addCloth(cards.keys.first);
    }

    notifyListeners();
  }

  Map<String, List<String>> get selectedCards =>
      _bucketInfoManager.getAllClothesMap();

  Future removeClothFromBucket(
      CardItem card, List<String> idCloth, String idBucket) async {
    try {
      await _removeClothFromBucketUseCase.handle(RemoveClothFromBucketRequest(
          idCloth
              .where((element) =>
                  !_bucketInfoManager.getAllClothes().contains(element))
              .toList(),
          idBucket));

      card.child.removeWhere((element) => idCloth.contains(element.id));
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
    }

    _notificationProvider.showNotification(
      "Peça/s removida/s com sucesso!",
      type: NotificationTypes.success,
    );

    notifyListeners();
  }

  Future unMarkClothsFromBucket(CardItem card, List<String> idsCloth) async {
    try {
      await _unMarkClothAsDailyUseUseCase.handle(idsCloth
          .where((element) =>
              !_bucketInfoManager.getAllClothes().contains(element))
          .toList());

      card.child
          .where((element) => idsCloth.contains(element.id))
          .forEach((element) {
        element.clothState = ClothStates.idle;
      });
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
    }

    _notificationProvider.showNotification(
      "Estado da/s peça/s atualizado!",
      type: NotificationTypes.success,
    );

    notifyListeners();
  }

  bool isBucketItem(CardItem card) => card.hasChildren;

  Future openInfoCard(CardItem card) async {
    AppRoute routePath;

    if (isBucketItem(card)) {
      routePath = ClothingRoutes.setBucketDetails(card.id);
    } else {
      routePath = ClothingRoutes.setClothDetails(card.id);
    }

    await _navigationRouter.pushAsync(routePath, extras: card);
    notifyListeners();
  }

  @override
  clone() {
    return InfoBucketViewModel(
      _bucketInfoManager,
      _notificationProvider,
      _removeClothFromBucketUseCase,
      _unMarkClothAsDailyUseUseCase,
      _navigationRouter,
    );
  }
}
