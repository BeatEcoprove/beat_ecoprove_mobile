import 'package:beat_ecoprove/core/domain/models/service.dart';

class ServiceParams {
  final Map<String, List<ServiceTemplate>> services;

  ServiceParams({
    required this.services,
  });
}
