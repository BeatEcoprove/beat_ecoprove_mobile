import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends FormViewModel implements Clone {
  final StaticValuesProvider _valuesProvider;

  final AuthenticationProvider _authProvider;
  late final User _user;
  late Map<String, dynamic> _selectedFilters = {};
  late List<String> _selectedHorizontalFilters = [];
  late List<FilterRow> _getColors = [];
  late List<FilterRow> _getBrands = [];

  late final List<Widget> _orders = [];

  late bool shouldUpdateData = true;

  OrdersViewModel(
    this._authProvider,
    this._valuesProvider,
  ) {
    _user = _authProvider.appUser;

    initializeFields([
      FormFieldValues.search,
    ]);
    getAllColors();
    getAllBrands();
  }

  User get user => _user;

  void setUpdateUpdateData(bool value) {
    shouldUpdateData = value;
  }

  void setSearch(String search) {
    try {
      setValue<String>(FormFieldValues.search, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  List<Widget> get orders => _orders;

  bool get haveHorizontalFilters => _selectedHorizontalFilters.isNotEmpty;

  List<String> get allSelectedHorizontalFilters => _selectedHorizontalFilters;

  bool haveThisHorizontalFilter(String filter) =>
      _selectedHorizontalFilters.contains(filter);

  void changeHorizontalFiltersSelection(List<String> filters) {
    _selectedHorizontalFilters = filters;
    notifyListeners();
  }

  bool haveThisFilter(String filter) => _selectedFilters.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilters;

  void changeFilterSelection(Map<String, dynamic> filters) {
    _selectedFilters = filters;
    notifyListeners();
  }

  List<FilterRow> get getFilters => _getColors + _getBrands;

  Future<List<FilterRow>> getAllColors() async {
    List<ColorItem> colors = [];
    List<FilterButtonItem> colorItems = [];

    try {
      colors = _valuesProvider.colors;
    } catch (e) {
      print("$e");
    }

    for (var color in colors) {
      colorItems.add(FilterButtonItem(
        text: color.name,
        value: color.hex,
        backgroundColor: Color(
          int.parse(
            color.hex,
            radix: 16,
          ),
        ),
        dimension: 30,
        tag: "color",
      ));
    }

    _getColors = [
      FilterRow(
        title: 'Cor',
        options: colorItems,
        isCircular: true,
      )
    ];
    return [FilterRow(options: colorItems, isCircular: true)];
  }

  Future<List<FilterRow>> getAllBrands() async {
    List<BrandItem> brands = [];
    List<FilterButtonItem> brandItems = [];

    try {
      brands = _valuesProvider.brands;
    } catch (e) {
      print("$e");
    }

    for (var brand in brands) {
      brandItems.add(FilterButtonItem(
        text: brand.name,
        dimension: 60,
        content: PresentImage(
            fit: BoxFit.scaleDown, path: ServerImage(brand.brandAvatar)),
        value: brand.name,
        tag: "brand",
      ));
    }

    _getBrands = [
      FilterRow(
        title: 'Marca',
        options: brandItems,
      )
    ];
    return [FilterRow(title: 'Marca', options: brandItems)];
  }

  Future<void> getOrders() async {
    return;
  }

  @override
  OrdersViewModel clone() {
    return OrdersViewModel(
      _authProvider,
      _valuesProvider,
    );
  }
}
