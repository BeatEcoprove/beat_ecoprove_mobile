import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/register_cloth/contracts/brand_result.dart';
import 'package:beat_ecoprove/register_cloth/contracts/color_result.dart';

class ClosetServiceProxy extends ClosetService {
  List<ColorResult> _allColors = [];
  List<BrandResult> _allBrands = [];

  ClosetServiceProxy(super.httpClient);

  @override
  Future<List<ColorResult>> getAllColors() async {
    if (_allColors.isEmpty) {
      _allColors = await super.getAllColors();
    }

    return _allColors;
  }

  @override
  Future<List<BrandResult>> getAllBrands() async {
    if (_allColors.isEmpty) {
      _allBrands = await super.getAllBrands();
    }

    return _allBrands;
  }
}
