import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/chat_rating_result.dart';
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

class GetRatingsUseCase
    implements
        UseCase<GetReviewsUseCaseRequest, Future<List<ChatRatingResult>>> {
  final StoreService _storeService;

  GetRatingsUseCase(this._storeService);

  @override
  Future<List<ChatRatingResult>> handle(request) async {
    List<ChatRatingResult> reviewsResult;

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
