import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';

class TermsViewModel extends FormViewModel {
  final INavigationManager _navigationRouter;

  static const _termsKey = 'terms';

  bool _accepted = false;
  bool get accepted => _accepted;

  TermsViewModel(this._navigationRouter);

  void toggleAccepted(bool? value) {
    _accepted = value ?? false;
    notifyListeners();
  }

  Future<bool> hasAcceptedTerms() async {
    return await bool.parse(await StorageService.getValue(_termsKey));
  }

  Future<void> acceptTerms() async {
    if (!_accepted) return;
    await StorageService.setValue<bool>(_termsKey, true);
    _navigationRouter.push(AuthRoutes.login);
  }
}
