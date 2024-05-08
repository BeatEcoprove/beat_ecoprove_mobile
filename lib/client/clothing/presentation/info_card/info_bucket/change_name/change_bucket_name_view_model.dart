import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/clothing/contracts/change_bucket_name_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/change_bucket_name_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/value_objects/bucket_name.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';

class ChangeBucketNameViewModel extends FormViewModel {
  final INotificationProvider _notificationProvider;
  final ChangeBucketNameUseCase _changeBucketNameUseCase;
  final INavigationManager _navigationRouter;

  ChangeBucketNameViewModel(
    this._notificationProvider,
    this._navigationRouter,
    this._changeBucketNameUseCase,
  ) {
    initializeFields([
      FormFieldValues.name,
    ]);
  }

  void setName(String name) {
    try {
      setValue<String>(
          FormFieldValues.name, BucketName.create(name).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  Future changeBucketName(CardItem bucket) async {
    var name = getValue(FormFieldValues.name).value ?? "";

    try {
      await _changeBucketNameUseCase.handle(ChangeBucketNameRequest(
        name,
        bucket.id,
      ));

      _notificationProvider.showNotification(
        "Cesto atualizado com sucesso!",
        type: NotificationTypes.success,
      );

      bucket.title = name;
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    _navigationRouter.pop();
    notifyListeners();
  }
}
