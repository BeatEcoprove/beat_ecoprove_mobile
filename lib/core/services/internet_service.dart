import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/providers/event_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetService extends ViewModel {
  Future<bool> checkServerApiConnection();
  Future<bool> checkInternetConnection();
  bool get wifiOn;
}

class InternetServiceImpl extends InternetService {
  final AuthenticationService _authService;
  final IEventProvider _eventProvider;

  InternetServiceImpl(this._authService, this._eventProvider) {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      wifiOn = results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.ethernet) ||
          results.contains(ConnectivityResult.mobile);
      print(wifiOn);
      _eventProvider.sendNotification(ChangeWifiStatusEvent(wifiOn));
    });
  }

  @override
  late bool wifiOn = false;

  @override
  Future<bool> checkInternetConnection() async {
    var connectionResult = await Connectivity().checkConnectivity();
    wifiOn = connectionResult.contains(ConnectivityResult.wifi) ||
        connectionResult.contains(ConnectivityResult.ethernet) ||
        connectionResult.contains(ConnectivityResult.mobile);

    return wifiOn;
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
