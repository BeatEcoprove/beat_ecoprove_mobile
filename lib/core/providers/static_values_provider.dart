import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_brands_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_colors_use_case.dart';

class StaticValuesProvider extends ViewModel {
  final List<ColorItem> colors = [];
  final List<BrandItem> brands = [];
  final AuthenticationProvider _authenticationProvider;
  final GetColorsUseCase _getColorsUseCase;
  final GetBrandsUseCase _getBrandsUseCase;

  StaticValuesProvider(
    this._authenticationProvider,
    this._getColorsUseCase,
    this._getBrandsUseCase,
  );

  Future fetchStaticValues() async {
    if (!_authenticationProvider.isAuthenticated) {
      return;
    }

    if (colors.isEmpty) {
      colors.addAll(await _getColorsUseCase.handle());
    }

    if (brands.isEmpty) {
      brands.addAll(await _getBrandsUseCase.handle());
    }

    notifyListeners();
  }

  bool get hasStaticValues => colors.isNotEmpty && brands.isNotEmpty;
}
