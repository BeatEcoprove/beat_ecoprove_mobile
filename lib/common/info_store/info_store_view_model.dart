import 'package:beat_ecoprove/common/info_store/info_store_params.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item_root.dart';
import 'package:beat_ecoprove/core/widgets/chat/content/chat_rating_item.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/chat_rating_result.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/get_ratings_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:beat_ecoprove/service_provider/stores/routes.dart';

class InfoStoreViewModel extends ViewModel<InfoStoreParams> {
  final INotificationProvider _notificationProvider;
  final INavigationManager _navigationRouter;
  final AuthenticationProvider _authProvider;
  final GetRatingsUseCase _getRatingsUseCase;

  late final User? user;

  final List<ChatItemRoot> reviews = [];

  late List<String> selectedFilter = [];
  final Map<String, String> filters = {
    "comments": "Comentários",
    "ratings": "Ratings"
  };

  InfoStoreViewModel(
    this._notificationProvider,
    this._navigationRouter,
    this._authProvider,
    this._getRatingsUseCase,
  ) {
    user = _authProvider.appUser;
  }

  @override
  void initSync() async {
    if (arg != null) {
      await fetchMessages(arg!.card.id);
    }
  }

  bool haveThisFilter(String filter) => selectedFilter.contains(filter);

  void changeFilterSelection(List<String> filter, String storeId) {
    selectedFilter = filter;
    fetchMessages(storeId);
  }

  Future fetchMessages(String storeId) async {
    try {
      for (var value in selectedFilter) {
        print(value);
      }

      var result = await _getRatingsUseCase.handle(
        GetReviewsUseCaseRequest(
          storeId,
        ),
      );

      reviews.clear();
      var mapReviews = result.map(
        (message) {
          return _messageBody(message);
        },
      );

      reviews.addAll(mapReviews);
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

  ChatItemRoot _messageBody(dynamic message) {
    switch (message.runtimeType) {
      case ChatRatingResult:
        return ChatItemRoot(
          userIsSender: message.senderId == user?.id,
          avatarUrl: message.avatarPicture,
          items: [
            ChaRatingItem(
              userName: message.username,
              messageText: "",
              rating: message.rating,
            ),
          ],
        );
      default:
        return ChatItemRoot(
          userIsSender: message.senderId == user?.id,
          avatarUrl: message.avatarPicture,
          items: [
            ChaRatingItem(
              userName: message.username,
              messageText: "",
              rating: message.rating,
            ),
          ],
        );
    }
  }

  void goToWorkersPage(StoreParams params) {
    _navigationRouter.push(StoreRoutes.setWorkers(params.storeId),
        extras: params);
  }
}
