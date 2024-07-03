import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ReadQRCodeViewModel extends ViewModel {
  final INotificationProvider _notificationProvider;
  final INavigationManager _navigationManager;

  ReadQRCodeViewModel(
    this._notificationProvider,
    this._navigationManager,
  );

  QRViewController? controller;

  onQRViewCreated(QRViewController qrViewController) {
    controller = qrViewController;

    try {
      controller!.scannedDataStream.take(1).listen((scanData) {
        //TODO: MAKE VALIDATION AND HANDLE

        _notificationProvider.showNotification(
          "QRCode válido!",
          type: NotificationTypes.success,
        );
        _navigationManager.pop();
      });
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
      _navigationManager.pop();
    } catch (e) {
      print(e.toString());
      _navigationManager.pop();
    }
  }
}
