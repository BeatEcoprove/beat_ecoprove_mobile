import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/payable_prize.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_params.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/widgets/service_button/payable_prize_button.dart';
import 'package:beat_ecoprove/core/widgets/service_button/service_button.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class WrapServices extends StatefulWidget {
  final String title;
  final String noResultsText;
  final List<ServiceTemplate> services;
  final double dimension;
  final Function(List<String>)? onSelectionChanged;
  final List<String> blockedServices;

  const WrapServices({
    super.key,
    required this.services,
    required this.title,
    required this.noResultsText,
    this.dimension = 110,
    required this.onSelectionChanged,
    required this.blockedServices,
  });

  const WrapServices.servicesItems({
    super.key,
    required this.services,
    required this.title,
    required this.noResultsText,
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
      colorBorder: service.borderColor,
      colorBackground: service.backgroundColor,
      object: service.content,
      dimension: widget.dimension,
      title: service.title,
      isSelect: selectedServices.contains(service.idText),
      isBlocked: widget.blockedServices.contains(service.idText),
    );
  }

  PayablePrizeButton renderPayableButton(PayablePrizeItem service) {
    return PayablePrizeButton(
      colorForeground: service.foregroundColor,
      colorBorder: service.borderColor,
      colorBackground: service.backgroundColor,
      object: service.content,
      dimension: widget.dimension,
      title: service.title,
      prize: service.prize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigator = DependencyInjection.locator<INavigationManager>();

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
                        navigator.push(
                          CoreRoutes.selectService,
                          extras: ServiceParams(
                            noResultsText: widget.noResultsText,
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
                child: service is PayablePrizeItem
                    ? renderPayableButton(service)
                    : renderServiceButton(service),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
