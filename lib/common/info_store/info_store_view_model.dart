import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';

class InfoStoreViewModel extends ViewModel {
  final INavigationManager _navigationRouter;

  late List<String> _selectedFilter = [];
  final Map<String, String> _filters = {
    "comments": "Comentários",
    "ratings": "Ratings"
  };

  InfoStoreViewModel(
    this._navigationRouter,
  );

  Map<String, String> get getFilters => _filters;

  List<String> get getSelectedFilter => _selectedFilter;

  bool haveThisFilter(String filter) => _selectedFilter.contains(filter);

  void changeFilterSelection(List<String> filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void goToWorkersPage(StoreParams params) {
    _navigationRouter.push(AppRoute.from("/store/${params.storeId}/workers"),
        extras: params);
  }
}
