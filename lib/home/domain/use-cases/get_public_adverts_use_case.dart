import 'package:beat_ecoprove/core/domain/models/advert_item.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/home/services/service_provider_service.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/advert_result.dart';

class GetPublicAdvertsUseCaseRequest {
  final int page;
  final int pageSize;

  GetPublicAdvertsUseCaseRequest({
    this.page = 1,
    this.pageSize = 100,
  });
}

class GetPublicAdvertsUseCase
    implements
        UseCase<GetPublicAdvertsUseCaseRequest, Future<List<AdvertItem>>> {
  final ServiceProviderService _serviceProviderService;

  GetPublicAdvertsUseCase(this._serviceProviderService);

  @override
  Future<List<AdvertItem>> handle(request) async {
    List<AdvertResult> publicAdvertsResult;

    try {
      publicAdvertsResult = await _serviceProviderService
          .getPublicAdverts(GetPublicAdvertsUseCaseRequest(
        page: request.page,
        pageSize: request.pageSize,
      ));
    } catch (e) {
      rethrow;
    }

    var advertsResult = publicAdvertsResult.map((ad) {
      return AdvertItem(
        advertId: ad.advertId,
        advertPicture: ad.advertPicture,
        title: ad.title,
        beginIn: ad.beginIn,
        endIn: ad.endIn,
        contentText: ad.contentText,
        contentSubText: ad.contentSubText,
      );
    }).toList();

    return advertsResult;
  }
}
