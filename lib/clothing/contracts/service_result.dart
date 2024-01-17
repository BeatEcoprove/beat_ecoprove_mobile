import 'package:beat_ecoprove/clothing/contracts/action_result.dart';

class ServiceResult {
  final String id;
  final String title;
  final String badge;
  final String description;
  final List<ActionResult> actions;

  ServiceResult(
    this.id,
    this.title, 
    this.badge, 
    this.description, 
    this.actions,
  );

  factory ServiceResult.fromJson(Map<String, dynamic> json) {
    return ServiceResult(
      json['id'],
      json['title'],
      json['badge'],
      json['description'],
      _convertJsonToActionResults(json['actions']),
    );
  }

  static List<ActionResult> _convertJsonToActionResults(List<dynamic> groups) {
    var group = groups.map((item) {
      return ActionResult.fromJson(item);
    }).toList();
    return group;
  }
}
