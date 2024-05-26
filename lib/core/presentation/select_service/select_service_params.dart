import 'package:beat_ecoprove/core/domain/models/service.dart';

class ServiceParams {
  final Map<String, List<ServiceTemplate>> services;
  final String noResultsText;

  ServiceParams({
    required this.services,
    required this.noResultsText,
  });
}
