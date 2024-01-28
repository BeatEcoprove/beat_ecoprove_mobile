import 'package:beat_ecoprove/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/remove_cloth_from_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class InfoBucketViewModel extends ViewModel {
  final NotificationProvider _notificationProvider;
  final RemoveClothFromBucketUseCase _removeClothFromBucketUseCase;
  final UnMarkClothAsDailyUseUseCase _unMarkClothAsDailyUseUseCase;
  final GoRouter _navigationRouter;

  late final Map<String, List<String>> _selectedCards = {};
  late final List<String> _selectedClothCards = [];

  InfoBucketViewModel(
    this._notificationProvider,
    this._removeClothFromBucketUseCase,
    this._unMarkClothAsDailyUseUseCase,
    this._navigationRouter,
  );

  void changeCardsSelection(Map<String, List<String>> cards) {
    if (_selectedCards.containsKey(cards.keys.first)) {
      _selectedCards.remove(cards.keys.first);
      _selectedClothCards.remove(cards.keys.first);
    } else {
      _selectedCards.addAll(cards);
      _selectedClothCards.add(cards.keys.first);
    }

    notifyListeners();
  }

  Map<String, List<String>> get selectedCards => _selectedCards;

  Future removeClothFromBucket(
      CardItem card, List<String> idCloth, String idBucket) async {
    try {
      await _removeClothFromBucketUseCase.handle(RemoveClothFromBucketRequest(
          idCloth
              .where((element) => !_selectedClothCards.contains(element))
              .toList(),
          idBucket));

      card.child.removeWhere((element) => idCloth.contains(element.id));
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
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
          .where((element) => !_selectedClothCards.contains(element))
          .toList());

      card.child
          .where((element) => idsCloth.contains(element.id))
          .forEach((element) {
        element.clothState = ClothStates.idle;
      });
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Estado da/s peça/s atualizado!",
      type: NotificationTypes.success,
    );

    notifyListeners();
  }

  bool isBucketItem(CardItem card) => card.hasChildren;

  Future openInfoCard(CardItem card) async {
    var path = isBucketItem(card)
        ? "/info/bucket/${card.id}"
        : "/info/cloth/${card.id}";

    await _navigationRouter.push(path, extra: card);
    notifyListeners();
  }
}
