import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:beat_ecoprove/service_provider/stores/routes.dart';

class StoreViewModel extends FormViewModel implements Clone {
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;
  late final User? _user;

  late Map<String, dynamic> _selectedFilters = {};

  StoreViewModel(
    this._authProvider,
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.search,
    ]);

    _user = _authProvider.appUser;
  }

  User? get user => _user;

  void setSearch(String search) {
    try {
      setValue<String>(FormFieldValues.search, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  // List<StoreItem> get stores => _stores;
  List<StoreItem> get stores => [
        StoreItem(
          id: "1",
          name: "Wash&Clean",
          numberWorkers: 10,
          country: "Portugal",
          locality: "Póvoa de Varzim",
          street: "Rua",
          postalCode: "4564-133",
          numberPort: "50",
          sustainablePoints: 250,
          rating: 5,
          picture: "public/profile/d9b26350-47ec-41c5-8303-f5e73474d996.png",
          level: 10,
        ),
      ];

  bool haveThisFilter(String filter) => _selectedFilters.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilters;

  void changeFilterSelection(Map<String, dynamic> filters) {
    _selectedFilters = filters;
    notifyListeners();
  }

  List<FilterRow> get getFilters => [];

  Future<void> getStores() async {
    //TODO: CREATE USE CASE TO GET MINE STORES
    return;
  }

  Future createStore() async {
    await _navigationRouter.pushAsync(StoreRoutes.createStore);
    notifyListeners();
  }

  void goToStore(StoreItem store) {
    _navigationRouter.push(AppRoute.from("/info/store/${store.id}"),
        extras: store);
  }

  @override
  StoreViewModel clone() {
    return StoreViewModel(
      _authProvider,
      _navigationRouter,
    );
  }
}
