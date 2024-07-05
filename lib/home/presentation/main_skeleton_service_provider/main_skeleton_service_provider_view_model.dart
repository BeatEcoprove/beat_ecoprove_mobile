import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view.dart';

class MainSkeletonServiceProviderViewModel extends ViewModel {
  final StaticValuesProvider _staticValuesProvider;

  MainSkeletonServiceProviderViewModel(this._staticValuesProvider);

  @override
  void initSync() async {
    await _staticValuesProvider.fetchStaticValues();
  }

  List<LinearView> getViews() {
    return [
      LinearView.of<HomeView>(),
      LinearView.of<OrdersView>(),
      LinearView.of<StoreView>(),
      LinearView.of<GroupView>(),
      LinearView.of<ServiceProviderProfileView>(),
    ];
  }
}
