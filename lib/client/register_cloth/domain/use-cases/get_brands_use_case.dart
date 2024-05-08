import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/brand_result.dart';

class GetBrandsUseCase implements UseCaseAction<Future> {
  final ClosetService _closetService;

  GetBrandsUseCase(this._closetService);

  @override
  Future<List<BrandItem>> handle() async {
    List<BrandResult> brandResult;
    List<BrandItem> brands = [];

    try {
      brandResult = await _closetService.getAllBrands();
    } catch (e) {
      rethrow;
    }

    for (var brand in brandResult) {
      brands.add(BrandItem(
        name: brand.name,
        brandAvatar: brand.brandAvatar,
      ));
    }

    return brands;
  }
}
