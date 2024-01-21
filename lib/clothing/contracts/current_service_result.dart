import 'package:beat_ecoprove/clothing/contracts/action_result.dart';
import 'package:beat_ecoprove/clothing/domain/models/service_state.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

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

  Service toService(Function(String, String, String) callback) {
    return Service(
      foregroundColor: AppColor.buttonBackground,
      borderColor: AppColor.buttonBackground,
      title: title,
      idText: id,
      backgroundColor: AppColor.widgetBackground,
      content: Image(
        image: ServerImage(badge),
      ),
      services: {
        "Encerre a ação de forma a concluí-la": [
          ServiceItem(
            foregroundColor: AppColor.buttonBackground,
            borderColor: AppColor.buttonBackground,
            title: runningAction.title,
            idText: runningAction.id,
            content: Image(
              image: ServerImage(runningAction.badge),
            ),
            backgroundColor: AppColor.widgetBackground,
            action: () async =>
                await callback(id, runningAction.id, ServiceState.running),
          )
        ]
      },
    );
  }
}
