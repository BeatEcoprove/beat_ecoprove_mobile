import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/home/domain/models/service_provider_item.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_provider_params.dart';
import 'package:beat_ecoprove/home/services/service_provider_service.dart';

class ServiceViewModel extends FormViewModel<ServiceProviderParams> {
  final AuthenticationProvider _authProvider;
  final ServiceProviderService _serviceProviderService;

  late final User? user;

  ServiceViewModel(
    this._authProvider,
    this._serviceProviderService,
  ) {
    user = _authProvider.appUser;

    initializeFields([
      FormFieldValues.code,
    ]);
  }

  @override
  void initSync() async {
    if (arg == null) return;

    await getServiceProvider(arg!.serviceProviderId);
  }

  Future getServiceProvider(String serviceProviderId) async {
    try {
      var result = await _serviceProviderService
          .getDetailsServiceProvider(serviceProviderId);

      var serviceProvider = ServiceProviderItem(
        id: result.id,
        name: result.name,
        type: result.type,
        icon: result.icon,
        //TODO: CHANGE
        services: [],
        rating: result.rating,
      );

      setValue(
        FormFieldValues.code,
        serviceProvider,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
