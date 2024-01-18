import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/presentation/select_service_view.dart';
import 'package:beat_ecoprove/core/widgets/service_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WrapServices extends StatefulWidget {
  final String title;
  final List<ServiceTemplate> services;
  final double dimension;
  final Function(List<String>)? onSelectionChanged;
  final List<String> blockedServices;

  const WrapServices({
    super.key,
    required this.services,
    required this.title,
    this.dimension = 110,
    required this.onSelectionChanged,
    required this.blockedServices,
  });

  const WrapServices.servicesItems({
    super.key,
    required this.services,
    required this.title,
    this.blockedServices = const [],
    this.dimension = 110,
  }) : onSelectionChanged = null;

  @override
  State<WrapServices> createState() => _WrapServicesState();
}

class _WrapServicesState extends State<WrapServices> {
  final List<String> selectedServices = [];

  ServiceButton renderServiceButton(ServiceTemplate service) {
    return ServiceButton(
      colorForeground: service.foregroundColor,
      colorBackground: service.backgroundColor,
      object: service.content,
      dimension: widget.dimension,
      title: service.title,
      isSelect: selectedServices.contains(service.idText),
      isBlocked: widget.blockedServices.contains(service.idText),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter goRouter = GoRouter.of(context);

    return Column(
      children: [
        Text(
          widget.title,
          style: AppText.titleToScrollSection,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          runSpacing: 6,
          spacing: 6,
          children: [
            for (var service in widget.services) ...[
              InkWell(
                onTap: () {
                  if (!widget.blockedServices.contains(service.idText)) {
                    if (!selectedServices.contains(service.idText)) {
                      if (service is Service) {
                        goRouter.push(
                          "/select_service",
                          extra: ServiceParams(
                            services: service.services,
                          ),
                        );
                      }
                      if (service is ServiceItem) {
                        service.action();
                      }
                    }
                  }
                },
                onLongPress: () {
                  if (service is Service) {
                    if (!widget.blockedServices.contains(service.idText)) {
                      setState(
                        () {
                          if (!widget.blockedServices
                              .contains(service.idText)) {
                            if (selectedServices.contains(service.idText)) {
                              selectedServices.remove(service.idText);
                            } else {
                              selectedServices.add(service.idText);
                            }
                            widget.onSelectionChanged!(selectedServices);
                          }
                        },
                      );
                    }
                  }
                },
                child: renderServiceButton(service),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
