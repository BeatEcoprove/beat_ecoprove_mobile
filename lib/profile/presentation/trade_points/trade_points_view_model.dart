import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';

class TradePointsViewModel extends FormViewModel {
  final AuthenticationProvider _authProvider;
  late final User _user;

  TradePointsViewModel(
    this._authProvider,
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
}
