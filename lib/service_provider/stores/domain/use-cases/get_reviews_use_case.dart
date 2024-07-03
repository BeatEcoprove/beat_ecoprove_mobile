import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/chat_messages.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class GetReviewsUseCaseRequest {
  final String storeId;
  final int page;
  final int pageSize;

  GetReviewsUseCaseRequest(
    this.storeId, {
    this.page = 1,
    this.pageSize = 50,
  });
}

class GetReviewsUseCase
    implements UseCase<GetReviewsUseCaseRequest, Future<ChatMessages>> {
  final StoreService _storeService;

  GetReviewsUseCase(this._storeService);

  @override
  Future<ChatMessages> handle(request) async {
    ChatMessages reviewsResult;

    try {
      reviewsResult = await _storeService.getRatings(
        request.storeId,
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
    }

    return reviewsResult;
  }
}
