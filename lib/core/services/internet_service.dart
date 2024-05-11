import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetService extends ViewModel {
  Future<bool> checkServerApiConnection();
  Future<bool> checkInternetConnection();
  bool get wifiOn;
}

class InternetServiceImpl extends InternetService {
  final AuthenticationService _authService;

  InternetServiceImpl(this._authService) {
    Connectivity().onConnectivityChanged.listen((event) {
      wifiOn = event.contains(ConnectivityResult.wifi);

      if (!wifiOn) {
        print("error internet connection failed");
      }

      notifyListeners();
    });
  }

  @override
  late bool wifiOn = false;

  @override
  Future<bool> checkInternetConnection() async {
    var connectionResult = await Connectivity().checkConnectivity();
    return connectionResult.contains(ConnectivityResult.wifi);
  }

  @override
  Future<bool> checkServerApiConnection() async {
    if (!await checkInternetConnection()) {
      return false;
    }

    try {
      await _authService.pingServer();
    } on HttpError {
      return false;
    }

    return true;
  }
}
