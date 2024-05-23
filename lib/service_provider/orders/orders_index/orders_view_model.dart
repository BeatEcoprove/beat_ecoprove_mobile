import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/service_provider/orders/domain/models/order_item.dart';
import 'package:beat_ecoprove/service_provider/orders/domain/use-cases/get_orders_use_case.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends FormViewModel implements Clone {
  final INotificationProvider _notificationProvider;
  final StaticValuesProvider _valuesProvider;
  final AuthenticationProvider _authProvider;
  late final User? user;
  late Map<String, dynamic> _selectedFilters = {};
  late List<String> _selectedHorizontalFilters = [];
  late List<FilterRow> _getColors = [];
  late List<FilterRow> _getBrands = [];
  late List<FilterRow> _getActiveOptions = [];
  late List<FilterRow> _getServices = [];

  final GetOrdersUseCase _getOrdersUseCase;

  late final List<OrderItem> orders = [];

  late bool shouldUpdateData = true;

  OrdersViewModel(
    this._notificationProvider,
    this._authProvider,
    this._valuesProvider,
    this._getOrdersUseCase,
  ) {
    user = _authProvider.appUser;

    initializeFields([
      FormFieldValues.search,
    ]);
    getAllColors();
    getAllBrands();
    getAllActiveOptions();
    getAllServices();
    _selectedFilters.addAll({
      "Concluídos": {"no": "isActive"}
    });
  }

  @override
  void initSync() async {
    await getOrders();
  }

  Future<void> refetch() async {
    await getOrders();
  }

  void setUpdateUpdateData(bool value) {
    shouldUpdateData = value;
  }

  void setSearch(String search) async {
    try {
      setValue<String>(FormFieldValues.search, search);

      await refetch();
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  bool get haveHorizontalFilters => _selectedHorizontalFilters.isNotEmpty;

  List<String> get allSelectedHorizontalFilters => _selectedHorizontalFilters;

  bool haveThisHorizontalFilter(String filter) =>
      _selectedHorizontalFilters.contains(filter);

  void changeHorizontalFiltersSelection(List<String> filters) async {
    _selectedHorizontalFilters = filters;
    await refetch();
  }

  bool haveThisFilter(String filter) => _selectedFilters.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilters;

  void changeFilterSelection(Map<String, dynamic> filters) async {
    _selectedFilters = filters;
    await refetch();
  }

  List<FilterRow> get getFilters =>
      _getActiveOptions + _getColors + _getBrands + _getServices;

  List<FilterRow> getAllActiveOptions() {
    List<FilterButtonItem> options = [];

    options.addAll([
      FilterButtonItem(
        text: "Ativos",
        dimension: 50,
        content: const Icon(
          Icons.check_circle_outline_rounded,
          size: 36,
          color: AppColor.darkGreen,
        ),
        value: "yes",
        tag: "isActive",
      ),
      FilterButtonItem(
        text: "Concluídos",
        dimension: 50,
        content: const Icon(
          Icons.highlight_off_rounded,
          size: 36,
          color: AppColor.endSession,
        ),
        value: "no",
        tag: "isActive",
      ),
    ]);

    _getActiveOptions = [
      FilterRow(
        title: "Concluído",
        options: options,
        hasOnlyOne: true,
      )
    ];

    return [FilterRow(title: "Concluído", options: options, hasOnlyOne: true)];
  }

  Future<List<FilterRow>> getAllColors() async {
    List<ColorItem> colors = [];
    List<FilterButtonItem> colorItems = [];

    try {
      colors = _valuesProvider.colors;
    } catch (e) {
      print(e.toString());
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
    return [FilterRow(title: 'Cor', options: colorItems, isCircular: true)];
  }

  Future<List<FilterRow>> getAllBrands() async {
    List<BrandItem> brands = [];
    List<FilterButtonItem> brandItems = [];

    try {
      brands = _valuesProvider.brands;
    } catch (e) {
      print(e.toString());
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

  //TODO: CHANGE TO SERVICES OF THE COMPANY
  List<FilterRow> getAllServices() {
    List<FilterButtonItem> options = [];

    options.addAll([
      FilterButtonItem(
        text: "Recycle",
        dimension: 50,
        content: const SvgImage(
          path: 'assets/services/recycle.svg',
          width: 25,
          height: 25,
        ),
        backgroundColor: AppColor.darkGreen,
        value: "recycle",
        tag: "services",
      ),
      FilterButtonItem(
        text: "Iron",
        dimension: 50,
        content: const SvgImage(
          path: 'assets/services/iron.svg',
          width: 30,
          height: 30,
        ),
        backgroundColor: AppColor.orange,
        value: "iron",
        tag: "services",
      ),
      FilterButtonItem(
        text: "Dry",
        dimension: 50,
        content: const SvgImage(
          path: 'assets/services/dry.svg',
          width: 30,
          height: 30,
        ),
        backgroundColor: AppColor.yellow,
        value: "dry",
        tag: "services",
      ),
      FilterButtonItem(
        text: "Wash",
        dimension: 50,
        content: const SvgImage(
          path: 'assets/services/wash.svg',
          width: 50,
          height: 50,
        ),
        backgroundColor: AppColor.lightBlue,
        value: "wash",
        tag: "services",
      ),
      FilterButtonItem(
        text: "Repair",
        dimension: 50,
        content: const SvgImage(
          path: 'assets/services/repair.svg',
          width: 30,
          height: 30,
        ),
        backgroundColor: AppColor.darkBlue,
        value: "repair",
        tag: "services",
      ),
    ]);

    _getServices = [
      FilterRow(
        title: 'Tipo de Serviços',
        options: options,
      )
    ];

    return [FilterRow(title: "Tipo de Serviços", options: options)];
  }

  Future getOrders() async {
    const int currentPage = 1;
    const int pageSize = 50;
    Map<String, String> param = {};

    try {
      for (var (value as Map<String, String>) in _selectedFilters.values) {
        param.addAll(value);
      }

      for (var filter in _selectedHorizontalFilters) {
        param.addAll({filter: 'localities'});
      }

      param.addAll({getValue(FormFieldValues.search).value ?? "": "search"});

      var result = await _getOrdersUseCase.handle(
        GetOrdersUseCaseRequest(
          param,
          page: currentPage,
          pageSize: pageSize,
        ),
      );

      orders.clear();
      orders.addAll(result);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  @override
  OrdersViewModel clone() {
    return OrdersViewModel(
      _notificationProvider,
      _authProvider,
      _valuesProvider,
      _getOrdersUseCase,
    );
  }
}
