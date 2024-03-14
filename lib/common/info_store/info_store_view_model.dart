import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_form.dart';
import 'package:go_router/go_router.dart';

class InfoStoreViewModel extends ViewModel {
  final NotificationProvider _notificationProvider;
  final GoRouter _navigationRouter;

  late List<String> _selectedFilter = [];
  final Map<String, String> _filters = {
    "comments": "Comentários",
    "ratings": "Ratings"
  };

  InfoStoreViewModel(
    this._notificationProvider,
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
    _navigationRouter.push("/store/${params.storeId}/workers", extra: params);
  }
}
