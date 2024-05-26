import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';

class ListWidgetViewModel extends FormViewModel {
  ListWidgetViewModel();

  void refresh() {
    notifyListeners();
  }
}
