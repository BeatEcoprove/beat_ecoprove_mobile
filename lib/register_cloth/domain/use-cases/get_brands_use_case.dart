import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/register_cloth/contracts/brand_result.dart';

class GetBrandsUseCase implements UseCaseAction<Future> {
  final ClosetService _closetService;

  GetBrandsUseCase(this._closetService);

  @override
  Future<List<BrandItem>> handle() async {
    List<BrandResult> brandResult;
    List<BrandItem> brands = [];

    try {
      brandResult = await _closetService.getAllBrands();
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }

    for (var color in brandResult) {
      brands.add(BrandItem(
        name: color.name,
      ));
    }

    return brands;
  }
}
