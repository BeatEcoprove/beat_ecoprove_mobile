import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/model/auth_user.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/address.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/postal_code.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:go_router/go_router.dart';

class SignInViewModel extends ViewModel {
  final List<String> _errorList = List.filled(11, '');

  late AuthUserModel _authUser;
  late List<String> _typeOptions;
  late Map<String, List<String>> _countries;

  late String _street;
  late PostalCode _postalCode;
  late int _port;

  late String _choosenCountry;
  late String _choosenLocality;

  late String _passwordTemp;
  late String _confirmPassword;

  late String _currentTypeOption;

  SignInViewModel() {
    _typeOptions = ["Lavandaria", "Reparador", "Reciclador"];

    _countries = {
      "Portugal": ["Póvoa de Varzim", "Vila do Conde"],
      "Inglaterra": ["Manchester"]
    };

    _street = '';
    _port = 0;
    _postalCode = PostalCode.create("");

    _currentTypeOption = _typeOptions.first;

    _choosenCountry = _countries.keys.first;
    _choosenLocality = _countries.values.first.first;

    _authUser = AuthUserModel(
        name: "Mario Esteves",
        bornDate: DateTime.now().subtract(const Duration(days: 20)),
        gender: Gender.male,
        userName: "Mario Esteves",
        avatarUrl: Uri(),
        email: "marioesteves@ipvc.pt",
        password: "password",
        address: Address.create("", 1, "", _postalCode),
        phone: Phone.create("+351", "123456789"));

    _passwordTemp = _confirmPassword = _authUser.password;
  }

  List<String> get currentLocalities => _countries[_choosenCountry] ?? [];
  String get choosenCountry => _choosenCountry;
  String get choosenLocality => _choosenLocality;
  Map<String, List<String>> get countries => Map.unmodifiable(_countries);

  List<String> get typeOptions => List.unmodifiable(_typeOptions);

  String get currentTypeOption => _currentTypeOption;

  void setLocality(String locality) {
    _choosenLocality = locality;
    notifyListeners();
  }

  void chooseCountry(String country) {
    _choosenCountry = country;
    setLocality(currentLocalities.first);

    notifyListeners();
  }

  String get street => _street;
  String get streetError => _errorList[0];

  void setStreet(String street) {
    if (street.isEmpty) {
      setError(0, "Preenche a rua");
    } else {
      cleanError(0);
      _street = street;
    }

    notifyListeners();
  }

  String get port => _port > 0 ? _port.toString() : '';
  String get portError => _errorList[1];

  void setPort(String port) {
    try {
      _port = int.parse(port);
    } catch (e) {
      return;
    }

    notifyListeners();
  }

  String get postalCode => _postalCode.toString();
  String get postalCodeError => _errorList[2];

  void setPostalCode(String postalCode) {
    _postalCode = PostalCode.create(postalCode);

    notifyListeners();
  }

  String get confirmPassword => _confirmPassword;
  String get confirmPasswordError => _errorList[3];

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();

    _validatePassowrd();
  }

  String get password => _passwordTemp;
  String get passwordError => _errorList[4];

  void setPassword(String password) {
    _passwordTemp = password;
    notifyListeners();

    _validatePassowrd();
  }

  void _validatePassowrd() {
    if (_passwordTemp != _confirmPassword) {
      return;
    }

    _authUser.password = _passwordTemp;
    notifyListeners();
  }

  String get email => _authUser.email;
  String get emailError => _errorList[5];

  void setEmail(String email) {
    _authUser.email = email;
    notifyListeners();
  }

  String get name => _authUser.name;
  String get nameError => _errorList[6];

  void setName(String name) {
    _authUser.name = name;
    notifyListeners();
  }

  DateTime get bornDate => _authUser.bornDate;
  String get bornDateError => _errorList[7];

  String get userName => _authUser.userName;
  String get userNameError => _errorList[8];

  void setUserName(String userName) {
    _authUser.userName = userName;
    notifyListeners();
  }

  String get gender => _authUser.gender.value;
  String get genderError => _errorList[9];

  void setGender(String gender) {
    _authUser.gender = Gender.getOf(gender);
    notifyListeners();
  }

  String get phone => _authUser.phone.value;
  String get phoneError => _errorList[10];

  void setPhone(String countryCode, String phone) {
    try {
      _authUser.phone = Phone.create(countryCode, phone);
    } on DomainException catch (e) {
      print(e.message);
    }

    notifyListeners();
  }

  cleanError(int index) {
    _errorList[index] = '';
  }

  setError(int index, String errorMessage) {
    _errorList[index] = errorMessage;
  }

  void setTypeOption(String type) {
    _currentTypeOption = type;
    notifyListeners();
  }

  void handleSignIn(GoRouter router) {
    router.go("/sign_in_complete");
  }
}
