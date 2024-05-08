import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/color_result.dart';

class GetColorsUseCase implements UseCaseAction<Future> {
  final ClosetService _closetService;

  GetColorsUseCase(this._closetService);

  @override
  Future<List<ColorItem>> handle() async {
    List<ColorResult> colorResult;
    List<ColorItem> colors = [];

    try {
      colorResult = await _closetService.getAllColors();
    } catch (e) {
      rethrow;
    }

    for (var color in colorResult) {
      colors.add(ColorItem(
        name: color.name,
        hex: color.hex,
      ));
    }

    return colors;
  }
}
