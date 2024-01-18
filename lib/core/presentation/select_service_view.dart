import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/wrap_services.dart';
import 'package:flutter/material.dart';

class ServiceParams {
  final Map<String, List<ServiceTemplate>> services;

  ServiceParams({
    required this.services,
  });
}

class SelectServiceView extends StatelessWidget {
  final ServiceParams services;

  const SelectServiceView({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        type: AppBackgrounds.closet,
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 98,
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: WrapServices.servicesItems(
                      title: services.services.keys.first,
                      services: services.services.values
                          .expand((value) => value)
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
