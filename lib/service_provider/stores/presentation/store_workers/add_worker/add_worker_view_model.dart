import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_params.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/add_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/add_worker_use_case.dart';

class AddWorkerViewModel extends FormViewModel {
  final INotificationProvider _notificationProvider;
  final INavigationManager _navigationRouter;
  final AddWorkerUseCase _addWorkerUseCase;

  final List<String> _types = ["Regular", "Gerente"];

  AddWorkerViewModel(
    this._notificationProvider,
    this._navigationRouter,
    this._addWorkerUseCase,
  ) {
    initializeFields([
      FormFieldValues.email,
      FormFieldValues.code,
    ]);
    setValue(FormFieldValues.code, _types.firstOrNull);
  }

  List<String> get types => _types;

  void setEmail(String email) {
    try {
      setValue<String>(FormFieldValues.email, Email.create(email).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.email, e.message);
    }
  }

  Future registerWorker(String storeId) async {
    try {
      await _addWorkerUseCase.handle(AddWorkerRequest(
        storeId,
        getValue(FormFieldValues.email).value ?? "",
        getValue(FormFieldValues.code).value ?? "Regular",
      ));

      _navigationRouter.pop();
      _navigationRouter.push(CoreRoutes.showCompleted,
          extras: ShowCompletedViewParams(
              text: "E-mail enviado!",
              textButton: "Voltar",
              action: () => _navigationRouter.pop()));
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
