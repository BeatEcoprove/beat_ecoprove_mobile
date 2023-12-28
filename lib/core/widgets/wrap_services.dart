import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/service_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WrapServices extends StatefulWidget {
  final String title;
  final List<ServiceTemplate> services;
  final double dimension;
  final Function(List<String>) onSelectionChanged;
  final List<String> blockedServices;

  const WrapServices({
    super.key,
    required this.services,
    required this.title,
    this.dimension = 100,
    required this.onSelectionChanged,
    required this.blockedServices,
  });

  @override
  State<WrapServices> createState() => _WrapServicesState();
}

class _WrapServicesState extends State<WrapServices> {
  final List<String> selectedServices = [];
  late List<Map<String, List<ServiceTemplate>>> passedServices = [
    {widget.title: widget.services}
  ];

  ServiceButton renderServiceButton(ServiceTemplate service) {
    return ServiceButton(
      colorBackground: AppColor.servicesCloth,
      object: service.content,
      dimension: widget.dimension,
      title: service.title,
      isSelect: selectedServices.contains(service.idText),
      isBlocked: widget.blockedServices.contains(service.idText),
    );
  }

  Widget renderServices() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            passedServices.last.keys.first,
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
              for (var service in passedServices.last.values
                  .expand((list) => list)
                  .toList()) ...[
                InkWell(
                  onTap: () {
                    if (!widget.blockedServices.contains(service.idText)) {
                      if (!selectedServices.contains(service.idText)) {
                        if (service is Service) {
                          setState(() {
                            passedServices.add({
                              service.services.keys.first: service
                                  .services.values
                                  .expand((list) => list)
                                  .toList()
                            });
                          });
                        }
                        if (service is ServiceItem) {
                          //TODO: Send update to server if is ServerItem
                          service.action;
                        }
                      }
                    }
                  },
                  onLongPress: () {
                    if (!widget.blockedServices.contains(service.idText)) {
                      if (service is Service) {
                        setState(
                          () {
                            if (!widget.blockedServices
                                .contains(service.idText)) {
                              if (selectedServices.contains(service.idText)) {
                                selectedServices.remove(service.idText);
                              } else {
                                selectedServices.add(service.idText);
                              }

                              widget.onSelectionChanged(selectedServices);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Stack(children: [
      Positioned(
        top: 18,
        left: 18,
        child: CircularButton(
          onPress: () {
            setState(() {
              goBack(goRouter);
            });
          },
          height: 46,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.widgetSecondary,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: 120,
          left: 36,
          right: 36,
          bottom: 16,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: renderServices(),
        ),
      ),
    ]);
  }

  void goBack(GoRouter goRouter) {
    passedServices.length == 1 ? goRouter.go('/') : passedServices.removeLast();
  }
}
