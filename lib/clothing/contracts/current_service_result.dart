
import 'package:beat_ecoprove/clothing/contracts/action_result.dart';

class CurrentServiceResult {
  final String id;
  final String title;
  final String badge;
  final String description;
  final ActionResult runningAction;

  CurrentServiceResult(
    this.id,
    this.title, 
    this.badge, 
    this.description, 
    this.runningAction,
  );

  factory CurrentServiceResult.fromJson(Map<String, dynamic> json) {
    return CurrentServiceResult(
      json['id'],
      json['title'],
      json['badge'],
      json['description'],
      ActionResult.fromJson(json['runningAction']),
    );
  }
}
