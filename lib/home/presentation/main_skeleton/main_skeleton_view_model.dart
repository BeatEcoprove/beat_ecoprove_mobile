import 'package:beat_ecoprove/client/clothing/presentation/closet/clothing_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view.dart';

class MainSkeletonViewModel extends ViewModel {
  late int currentIndex = 0;
  final StaticValuesProvider _staticValuesProvider;

  MainSkeletonViewModel(this._staticValuesProvider);

  @override
  void initSync() async {
    await _staticValuesProvider.fetchAuthorizedValues();
  }

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<LinearView> getViews() {
    return [
      LinearView.of<HomeView>(),
      LinearView.of<ClothingView>(),
      LinearView.of<GroupView>(),
      LinearView.of<ProfileView>(),
    ];
  }
}
