import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/errors/no_clothes_exception.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_params.dart';
import 'package:beat_ecoprove/client/clothing/routes.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoBucketViewModel extends ViewModel<InfoBucketParams> implements Clone {
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

  @override
  void initSync() {
    if (arg == null) return;

    for (var card in arg!.card.child as List<CardItem>) {
      if (card.clothState == ClothStates.blocked) {
        _bucketInfoManager.addCloth(card.id);
      }
    }
  }

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
      var clothes = idCloth.where(
          (element) => !_bucketInfoManager.getAllClothes().contains(element));

      if (clothes.isEmpty) {
        throw NoClothesException("Não tem peças de roupa selecionadas!");
      }

      await _removeClothFromBucketUseCase
          .handle(RemoveClothFromBucketRequest(clothes.toList(), idBucket));

      _navigationRouter.pop();
      _bucketInfoManager.removeClothes();

      _notificationProvider.showNotification(
        "Peça/s removida/s com sucesso!",
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } on NoClothesException catch (e) {
      _notificationProvider.showNotification(
        e.message,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future unMarkClothsFromBucket(CardItem card, List<String> idsCloth) async {
    try {
      var clothes = idsCloth.where(
          (element) => !_bucketInfoManager.getAllClothes().contains(element));

      if (clothes.isEmpty) {
        throw NoClothesException("Não tem peças de roupa selecionadas!");
      }

      await _unMarkClothAsDailyUseUseCase.handle(clothes.toList());

      card.child
          .where((element) => idsCloth.contains(element.id))
          .forEach((element) {
        element.clothState = ClothStates.idle;
      });

      _navigationRouter.pop();
      _bucketInfoManager.removeClothes();

      _notificationProvider.showNotification(
        "Estado da/s peça/s atualizado!",
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } on NoClothesException catch (e) {
      _notificationProvider.showNotification(
        e.message,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

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
