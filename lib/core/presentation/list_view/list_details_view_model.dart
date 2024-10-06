import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';

class ListDetailsViewModel extends FormViewModel {
  ListDetailsViewModel() {
    initializeFields([
      FormFieldValues.search,
      FormFieldValues.page,
      FormFieldValues.pageSize,
    ]);
  }

  void setSearch(String search) {
    try {
      setValue<String>(FormFieldValues.search, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  void setPage(int page) {
    try {
      setValue<int>(FormFieldValues.page, page);
    } on DomainException catch (e) {
      setError(FormFieldValues.page, e.message);
    }
  }

  void setPageSize(int pageSize) {
    try {
      setValue<int>(FormFieldValues.pageSize, pageSize);
    } on DomainException catch (e) {
      setError(FormFieldValues.pageSize, e.message);
    }
  }

  void refresh() {
    notifyListeners();
  }
}
