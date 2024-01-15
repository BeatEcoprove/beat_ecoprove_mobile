import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class InfoClothServiceViewModel extends ViewModel {
  late List<String> _selectedServices = [];
  final List<String> _blockedServices = [];
  final List<ServiceTemplate> _services = [
    Service(
      title: "Cesto",
      idText: "bucket",
      content: const SvgImage(
        path: "assets/services/bucket.svg",
        height: 30,
        width: 30,
        color: AppColor.buttonBackground,
      ),
      services: {
        "Em que cesto pretende adicionar esta peça?": [
          ServiceItem(
            title: "Novo cesto",
            idText: "bucket_new_bucket",
            content: const Icon(
              Icons.add,
              size: 50,
              color: AppColor.buttonBackground,
            ),
            action: () {},
          ),
        ]
      },
    ),
    Service(
        title: "Lavar",
        idText: "wash",
        content: const SvgImage(
          path: "assets/services/wash.svg",
          height: 50,
          width: 50,
          color: AppColor.buttonBackground,
        ),
        services: {
          "De que forma pretende lavar a peça?": [
            ServiceItem(
              title: "À mão",
              idText: "wash_hand",
              content: const SvgImage(
                path: "assets/services/wash/hand.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "A menos de 30º",
              idText: "wash_less_30",
              content: const SvgImage(
                path: "assets/services/wash/less30.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "A menos de 50º",
              idText: "wash_less_50",
              content: const SvgImage(
                path: "assets/services/wash/less50.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "A menos de 70º",
              idText: "wash_less_70",
              content: const SvgImage(
                path: "assets/services/wash/less70.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "A menos de 95º",
              idText: "wash_less_95",
              content: const SvgImage(
                path: "assets/services/wash/less95.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "A seco",
              idText: "wash_dry",
              content: const SvgImage(
                path: "assets/services/wash/dry.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "Serviço",
              idText: "wash_service",
              content: const SvgImage(
                path: "assets/services/service.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
          ]
        }),
    Service(
        title: "Secar",
        idText: "dry",
        content: const SvgImage(
          path: "assets/services/dry.svg",
          height: 50,
          width: 50,
          color: AppColor.buttonBackground,
        ),
        services: {
          "De que forma pretende secar a roupa?": [
            ServiceItem(
              title: "Ao ar livre",
              idText: "dry_air",
              content: const SvgImage(
                path: "assets/services/dry/air.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "Na máquina",
              idText: "dry_machine",
              content: const SvgImage(
                path: "assets/services/dry/machine.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "Serviço",
              idText: "dry_service",
              content: const SvgImage(
                path: "assets/services/service.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
          ]
        }),
    Service(
        title: "Engomar",
        idText: "iron",
        content: const SvgImage(
          path: "assets/services/iron.svg",
          height: 50,
          width: 50,
          color: AppColor.buttonBackground,
        ),
        services: {
          "De que forma pretende engomar a peça?": [
            ServiceItem(
              title: "A menos de 110º",
              idText: "iron_less_110",
              content: const SvgImage(
                path: "assets/services/iron/less110.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "A menos de 150º",
              idText: "iron_less_150",
              content: const SvgImage(
                path: "assets/services/iron/less150.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "A menos de 200º",
              idText: "iron_less_200",
              content: const SvgImage(
                path: "assets/services/iron/less200.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "Serviço",
              idText: "iron_service",
              content: const SvgImage(
                path: "assets/services/service.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
          ]
        }),
    Service(
        title: "Arranjar",
        idText: "repair",
        content: const SvgImage(
          path: "assets/services/repair.svg",
          height: 50,
          width: 50,
          color: AppColor.buttonBackground,
        ),
        services: {
          "De que forma pretende arranjar a peça?": [
            ServiceItem(
              title: "Pelo próprio",
              idText: "repair_myself",
              content: const SvgImage(
                path: "assets/services/repair.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            ServiceItem(
              title: "Serviço",
              idText: "repair_service",
              content: const SvgImage(
                path: "assets/services/service.svg",
                height: 50,
                width: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
          ]
        }),
    ServiceItem(
      title: "Enviar para reciclagem",
      idText: "recycle",
      content: const SvgImage(
        path: "assets/services/recycle.svg",
        height: 50,
        width: 50,
        color: AppColor.buttonBackground,
      ),
      action: () {},
    ),
    ServiceItem(
      title: "Colocar no lixo",
      idText: "trash",
      content: const SvgImage(
        path: "assets/services/trash.svg",
        height: 50,
        width: 50,
        color: AppColor.buttonBackground,
      ),
      action: () {},
    ),
  ];

  InfoClothServiceViewModel();

  bool get haveServicesSelected => _selectedServices.isNotEmpty;

  void changeServiceSelection(List<String> services) {
    _selectedServices = services;

    notifyListeners();
  }

  List<String> blockedServices() {
    return _blockedServices;
  }

  List<ServiceTemplate> get getAllServices => _services;
}
