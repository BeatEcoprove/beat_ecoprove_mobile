import 'dart:async';

import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/services/country_codes_service.dart';
import 'package:beat_ecoprove/core/services/geo_api_service.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/use-cases/get_brands_use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/use-cases/get_colors_use_case.dart';

class StaticValuesProvider extends ViewModel {
  final AuthenticationProvider _authenticationProvider;
  final GetColorsUseCase _getColorsUseCase;
  final GetBrandsUseCase _getBrandsUseCase;
  final CountryCodesService _countryCodesService;
  final GeoApiService _apiService;

  final Map<String, ColorItem> colorsMap = {};
  final Map<String, BrandItem> brandsMap = {};
  final Map<String, String> countryCodes = {};
  final Map<String, List<String>> countryParishes = {};

  StaticValuesProvider(
    this._authenticationProvider,
    this._getColorsUseCase,
    this._getBrandsUseCase,
    this._countryCodesService,
    this._apiService,
  );

  List<ColorItem> get colors => colorsMap.values.toList();
  List<BrandItem> get brands => brandsMap.values.toList();

  Future _fetchValues() async {
    List<Future> values = [
      _countryCodesService.getCountryCodes(),
      _apiService.getParishes()
    ];

    var result = await Future.wait(values);
    countryCodes.addAll(result[0]);
    countryParishes.addAll(result[1]);
  }

  Future fetchAuthorizedValues() async {
    if (!_authenticationProvider.isAuthenticated) {
      return;
    }

    List<Future> values = [
      _getColorsUseCase.handle(),
      _getBrandsUseCase.handle()
    ];

    var result = await Future.wait(values);
    var colors = Map.castFrom<dynamic, dynamic, String, ColorItem>(
        {for (var color in result[0]) color.hex: color});

    var brands = Map.castFrom<dynamic, dynamic, String, BrandItem>(
        {for (var brand in result[1]) brand.name: brand});

    colorsMap.addAll(colors);
    brandsMap.addAll(brands);
  }

  Future fetchStaticValues() async {
    await fetchAuthorizedValues();
    await _fetchValues();

    notifyListeners();
  }

  bool get hasStaticValues => colors.isNotEmpty && brands.isNotEmpty;
}
