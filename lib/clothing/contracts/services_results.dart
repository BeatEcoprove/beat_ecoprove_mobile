import 'package:beat_ecoprove/clothing/contracts/service_result.dart';

class ServicesResults {
  final List<ServiceResult> publicGroups;

  ServicesResults(
    this.publicGroups,
  );

  factory ServicesResults.fromJson(Map<String, dynamic> json) {
    return ServicesResults(
      _convertJsonToServiceResult(json['publicGroups']),
    );
  }

  static List<ServiceResult> _convertJsonToServiceResult(List<dynamic> groups) {
    var group = groups.map((item) {
      return ServiceResult.fromJson(item);
    }).toList();
    return group;
  }
}
