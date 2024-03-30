import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class MakeProfileActionViewModel extends ViewModel {
  final INavigationManager _navigationManager;

  MakeProfileActionViewModel(this._navigationManager);

  void goBack() {
    _navigationManager.pop();
  }
}
