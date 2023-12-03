import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/widgets/service_button.dart';
import 'package:flutter/material.dart';

class WrapServices extends StatefulWidget {
  final String title;
  final List<ServiceItem> services;
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
  late String title = widget.title;
  late List<ServiceItem> services = widget.services;

  ServiceButton renderServiceButton(ServiceItem service) {
    return ServiceButton(
      colorBackground: AppColor.servicesCloth,
      object: service.content,
      dimension: widget.dimension,
      title: service.title,
      isSelect: selectedServices.contains(service.idText),
      isBlocked: widget.blockedServices.contains(service.idText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
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
            for (var service in services) ...[
              InkWell(
                onTap: () {
                  if (service is Service) {
                    setState(() {
                      title = service.services.keys.first;
                      services = service.services.values
                          .expand((list) => list)
                          .toList();
                    });
                  }
                  // Send update to server if is ServerItem
                },
                onLongPress: () {
                  if (service is Service) {
                    setState(
                      () {
                        if (!widget.blockedServices.contains(service.idText)) {
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
