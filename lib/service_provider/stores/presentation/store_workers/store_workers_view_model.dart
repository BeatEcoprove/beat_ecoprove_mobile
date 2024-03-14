import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/worker.dart';
import 'package:go_router/go_router.dart';

class StoreWorkersViewModel extends FormViewModel {
  final NotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final GoRouter _navigationRouter;

  late final User _user;
  final List<Worker> _workers = [
    Worker(id: '1', name: 'Zé', email: 'ze@gmail.com', type: 'regularWorker'),
  ];
  final List<String> _types = ["Regular", "Gerente"];

  //TODO: ADD ACTION
  final List<OptionItem> _options = [
    OptionItem(name: "Remover", action: () => {}),
  ];

  StoreWorkersViewModel(
    this._notificationProvider,
    this._authProvider,
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.code,
    ]);
    _user = _authProvider.appUser;
    setValue(FormFieldValues.code, _types.firstOrNull);
  }

  User get user => _user;

  List<OptionItem> get options => _options;

  List<String> get types => _types;

  List<Worker> get workers => _workers;

  Future<void> getWorkers(String storeId) async {
    //TODO: CREATE SERVICE
    return;
  }

  Future addWorker(String storeId) async {
    await _navigationRouter.push("/store/$storeId/addWorkers");
    notifyListeners();
  }
}
