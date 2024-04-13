import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/client/profile/contracts/trade_points_request.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/trade_points_use_case.dart';

class TradePointsViewModel extends FormViewModel {
  final INotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final TradePointsUseCase _tradePointsUseCase;
  final INavigationManager _navigationRouter;
  late final User _user;

  TradePointsViewModel(
    this._navigationRouter,
    this._notificationProvider,
    this._authProvider,
    this._tradePointsUseCase,
  ) {
    _user = _authProvider.appUser;
    initializeFields([
      FormFieldValues.ecoCoins,
      FormFieldValues.sustainablePoints,
    ]);
    setValue(FormFieldValues.ecoCoins, 0);
    setValue(FormFieldValues.sustainablePoints, 0);
  }

  void setQuantityEcoCoins(String receive) {
    int ecoCoins = 0;
    receive.isEmpty ? ecoCoins = 0 : ecoCoins = int.parse(receive);
    try {
      setValue<int>(FormFieldValues.ecoCoins, ecoCoins);
    } on DomainException catch (e) {
      setError(FormFieldValues.ecoCoins, e.message);
    }
  }

  void setQuantitySustainablePoints(String receive) {
    int sustainablePoints = 0;
    receive.isEmpty
        ? sustainablePoints = 0
        : sustainablePoints = int.parse(receive);
    try {
      setValue<int>(FormFieldValues.sustainablePoints, sustainablePoints);
    } on DomainException catch (e) {
      setError(FormFieldValues.sustainablePoints, e.message);
    }
  }

  User get user => _user;

  int get getEcoCoins => 100;
  int get getSustainablePoints => 10;

  Future<void> tradePoints() async {
    try {
      await _tradePointsUseCase.handle(TradePointsRequest(
        getValue(FormFieldValues.ecoCoins).value ?? 0,
        getValue(FormFieldValues.sustainablePoints).value ?? 0,
      ));

      _notificationProvider.showNotification(
        "Troca realizada!",
        type: NotificationTypes.success,
      );

      _navigationRouter.pop();
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
  }
}
