import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class SelectUserViewModel extends ViewModel {
  final INavigationManager _navigationRouter;
  late int _selectionIndex = 0;
  final List<String> _urlScreens = [
    SignUseroptions.personal.label,
    SignUseroptions.enterprise.label
  ];

  SelectUserViewModel(
    this._navigationRouter,
  );

  int get selectionIndex => _selectionIndex;

  setSelectionIndex(int value) {
    _selectionIndex = value;
    notifyListeners();
  }

  handleSignIn() {
    _navigationRouter.push(
      AuthRoutes.setSignIn(
        _urlScreens[_selectionIndex],
      ),
    );
  }
}
