import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';

class SeeBrandsViewModel extends FormViewModel {
  final INavigationManager _navigationRouter;
  final StaticValuesProvider _valuesProvider;

  late final List<BrandItem> brands;

  SeeBrandsViewModel(
    this._navigationRouter,
    this._valuesProvider,
  ) {
    brands = _valuesProvider.brands;
  }

  void goToCreateBrand() async {
    await _navigationRouter.pushAsync(CoreRoutes.createBrand);
  }
}
