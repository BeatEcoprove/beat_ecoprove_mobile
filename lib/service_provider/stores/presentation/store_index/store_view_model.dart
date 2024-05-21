import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/common/info_store/info_store_params.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/get_stores_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/routes.dart';

class StoreViewModel extends FormViewModel implements Clone {
  final INotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;
  final GetStoresUseCase _getStoresUseCase;
  late final User? user;

  final List<StoreItem> stores = [];

  late Map<String, dynamic> _selectedFilters = {};

  StoreViewModel(
    this._notificationProvider,
    this._authProvider,
    this._navigationRouter,
    this._getStoresUseCase,
  ) {
    initializeFields([
      FormFieldValues.search,
    ]);

    user = _authProvider.appUser;
  }

  void setSearch(String search) {
    try {
      setValue<String>(FormFieldValues.search, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  bool haveThisFilter(String filter) => _selectedFilters.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilters;

  void changeFilterSelection(Map<String, dynamic> filters) {
    _selectedFilters = filters;
    notifyListeners();
  }

  List<FilterRow> get getFilters => [];

  Future getStores() async {
    Map<String, String> param = {};

    try {
      stores.clear();

      param.addAll({getValue(FormFieldValues.search).value ?? "": "search"});

      var workersResult = await _getStoresUseCase.handle(
        GetStoresUseCaseRequest(
          param,
        ),
      );

      stores.addAll(workersResult);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future createStore() async {
    await _navigationRouter.pushAsync(StoreRoutes.createStore);
    notifyListeners();
  }

  void goToStore(StoreItem store) {
    _navigationRouter.push(
      StoreRoutes.setStoreDetails(store.id),
      extras: InfoStoreParams(store),
    );
  }

  @override
  StoreViewModel clone() {
    return StoreViewModel(
      _notificationProvider,
      _authProvider,
      _navigationRouter,
      _getStoresUseCase,
    );
  }
}
