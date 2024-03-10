import 'package:beat_ecoprove/client/clothing/contracts/action_result.dart';
import 'package:beat_ecoprove/client/clothing/domain/models/service_state.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

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

  Service toService(Function(String, String, String) callback) {
    return Service<List<ServiceItem>>(
      foregroundColor: AppColor.buttonBackground,
      borderColor: Colors.transparent,
      backgroundColor: AppColor.widgetBackground,
      title: title,
      idText: id,
      content: Image(
        image: ServerImage(badge),
      ),
      services: {
        description: actions
            .map(
              (action) => ServiceItem(
                foregroundColor: AppColor.buttonBackground,
                borderColor: Colors.transparent,
                backgroundColor: AppColor.widgetBackground,
                title: action.title,
                idText: action.id,
                content: Image(
                  image: ServerImage(action.badge),
                ),
                action: () async =>
                    await callback(id, action.id, ServiceState.available),
              ),
            )
            .toList()
      },
    );
  }
}
// const SvgImage(
//         path: "",
//         height: 30,
//         width: 30,
//         color: AppColor.buttonBackground,
//       ),
