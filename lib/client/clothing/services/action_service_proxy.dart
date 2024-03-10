import 'package:beat_ecoprove/client/clothing/contracts/service_result.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service.dart';

class ActionServiceProxy extends ActionService {
  List<ServiceResult> _allServices = [];

  ActionServiceProxy(super.httpClient);

  @override
  Future<List<ServiceResult>> getAllServices() async {
    if (_allServices.isEmpty) {
      _allServices = await super.getAllServices();
    }

    return _allServices;
  }
}
