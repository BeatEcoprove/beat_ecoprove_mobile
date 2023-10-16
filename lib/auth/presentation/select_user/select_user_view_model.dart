import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class SelectUserViewModel extends ViewModel {
  final List<String> _urlScreens = [
    "/sign_in/${SignUserType.personal.name}",
    "/sign_in/${SignUserType.enterprise.name}"
  ];
  late int _selectionIndex = 0;

  int get selectionIndex => _selectionIndex;

  setSelectionIndex(int value) {
    _selectionIndex = value;
    notifyListeners();
  }

  handleSignIn(GoRouter router) {
    router.go(_urlScreens[_selectionIndex]);
  }
}
