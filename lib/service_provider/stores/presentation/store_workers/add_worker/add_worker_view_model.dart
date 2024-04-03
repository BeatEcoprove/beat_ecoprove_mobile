import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/email.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_params.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/routes.dart';

class AddWorkerViewModel extends FormViewModel {
  final NotificationProvider _notificationProvider;
  final INavigationManager _navigationRouter;

  final List<String> _types = ["Regular", "Gerente"];

  AddWorkerViewModel(
    this._notificationProvider,
    this._navigationRouter,
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

  Future registerWorker() async {
    try {
      //TODO: ADD USE CASE AND SERVICE
      // await _addWorkerUseCase.handle(AddWorkerRequest(
      //   getValue(FormFieldValues.email).value ?? "",
      //   getValue(FormFieldValues.code).value ?? "Regular",
      // ));

      _navigationRouter.pop();
      _navigationRouter.push(CoreRoutes.showCompleted,
          extras: ShowCompletedViewParams(
              text: "E-mail enviado!",
              textButton: "Voltar",
              action: () => _navigationRouter.pop()));
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    notifyListeners();
  }
}
