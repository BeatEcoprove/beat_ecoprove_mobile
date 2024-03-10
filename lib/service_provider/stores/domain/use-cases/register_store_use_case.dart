import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/register_store_request.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class RegisterStoreUseCase implements UseCase<RegisterStoreRequest, Future> {
  final StoreService _storeService;

  RegisterStoreUseCase(this._storeService);

  @override
  Future handle(RegisterStoreRequest request) async {
    try {
      await _storeService.registerStore(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
