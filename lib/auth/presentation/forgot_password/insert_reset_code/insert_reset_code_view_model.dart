import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class InsertResetCodeViewModel extends ViewModel {
  final GoRouter _navigationRouter;

  InsertResetCodeViewModel(this._navigationRouter) {}

  void verifyCode() {
    _navigationRouter.pushReplacement("/reset_password");
  }
}
