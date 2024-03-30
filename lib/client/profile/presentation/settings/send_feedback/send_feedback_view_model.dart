import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/client/profile/contracts/send_feedback_request.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/send_feedback_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/value_objects/feedback_description.dart';
import 'package:beat_ecoprove/client/profile/domain/value_objects/feedback_name.dart';

class SendFeedbackViewModel extends FormViewModel {
  late final User _user;
  final AuthenticationProvider _authProvider;
  final NotificationProvider _notificationProvider;
  final SendFeedbackUseCase _sendFeedbackUseCase;
  final INavigationManager _navigationRouter;

  SendFeedbackViewModel(
    this._notificationProvider,
    this._authProvider,
    this._sendFeedbackUseCase,
    this._navigationRouter,
  ) {
    _user = _authProvider.appUser;
    initializeFields([
      FormFieldValues.name,
      FormFieldValues.groupDescription,
    ]);
  }

  User get user => _user;

  void setName(String name) {
    try {
      setValue<String>(
          FormFieldValues.name, FeedbackName.create(name).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  void setDescription(String description) {
    try {
      setValue<String>(FormFieldValues.groupDescription,
          FeedbackDescription.create(description).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.groupDescription, e.message);
    }
  }

  Future sendFeedback() async {
    try {
      await _sendFeedbackUseCase.handle(SendFeedbackRequest(
        getValue(FormFieldValues.name).value ?? "",
        getValue(FormFieldValues.groupDescription).value ?? "",
      ));

      _notificationProvider.showNotification(
        "Feedback enviado!",
        type: NotificationTypes.success,
      );
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
    }

    notifyListeners();
    _navigationRouter.pop();
  }
}
