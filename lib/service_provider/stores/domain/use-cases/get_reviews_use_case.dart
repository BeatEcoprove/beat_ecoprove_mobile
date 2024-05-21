import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/chat_messages.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class GetReviewsUseCaseRequest {
  final String storeId;
  final Map<String, String> params;
  final int page;
  final int pageSize;

  GetReviewsUseCaseRequest(
    this.storeId,
    this.params, {
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
    String filters = '';

    if (request.params.isNotEmpty) {
      filters = _prepareRequest(request.params);
    }

    try {
      reviewsResult = await _storeService.getReviews(
        request.storeId,
        filters,
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
    }

    filters = '';
    return reviewsResult;
  }

  String _prepareRequest(Map<String, String> params) {
    Set<String> tags = {};
    String endPoint = '&';

    for (var param in params.values) {
      tags.add(param);
    }

    for (var tag in tags) {
      endPoint +=
          '$tag=${params.entries.where((entry) => entry.value.contains(tag)).map((entry) => entry.key).join(',')}';
      endPoint += '&';
    }

    return endPoint;
  }
}
