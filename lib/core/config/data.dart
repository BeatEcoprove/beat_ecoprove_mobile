import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class CardData {
  final String title;
  final String subtitle;
  final Widget widget;

  CardData({
    required this.title,
    required this.subtitle,
    required this.widget,
  });
}

List<CardData> cards = [
  CardData(
    title: "A loja Wash&Clean oferece 50% de desconto na primeira lavagem",
    subtitle: "Em todas as lojas de Portugal Continental",
    widget: const PresentImage(
      path: AssetImage("assets/fakedata/dry.jpg"),
    ),
  ),
  CardData(
    title: "Lavandaria e Engomadoria",
    subtitle:
        "Torne sua vida mais fácil! Deixe-nos cuidar da sua roupa. Desfrute de 20% de desconto na sua primeira lavagem e engomadoria. Serviço rápido e eficiente!",
    widget: const PresentImage(
      path: AssetImage("assets/fakedata/dry2.jpg"),
    ),
  ),
  CardData(
    title: "Arranjos Rápidos",
    subtitle:
        "Tem uma roupa para ajustar? Oferecemos arranjos rápidos e precisos. Primeira alteração com 15% de desconto. Transformamos a sua roupa para que fique perfeita!",
    widget: const PresentImage(
      path: AssetImage("assets/fakedata/repair.jpg"),
    ),
  ),
  CardData(
    title: "Lavagem a Seco Premium - Preservamos a beleza da sua roupa!",
    subtitle:
        "Experimente a nossa lavagem a seco premium com 30% de desconto na primeira vez. Tratamos cada peça com o cuidado que merece.",
    widget: const PresentImage(
      path: AssetImage("assets/fakedata/wash.jpg"),
    ),
  ),
];

class ServiceData {
  final String title;
  final String subtitle;
  final Widget widget;

  ServiceData(
      {required this.title, required this.subtitle, required this.widget});
}

List<ServiceData> services = [
  ServiceData(
    title: "Wash&Clean",
    subtitle: "Lavandaria",
    widget: const Icon(
      Icons.water_drop_outlined,
      color: AppColor.lightBlue,
    ),
  ),
  ServiceData(
    title: "Arranjos Express",
    subtitle: "Arranjo",
    widget: SvgImage(
      path: 'assets/services/repair.svg',
      width: 30,
      height: 30,
      color: AppColor.orange,
    ),
  ),
  ServiceData(
    title: "Seco & Leve",
    subtitle: "Secagem",
    widget: SvgImage(
      path: 'assets/services/dry.svg',
      width: 30,
      height: 30,
      color: AppColor.primaryColor,
    ),
  ),
];

class ServiceViewData {
  final String title;
  final String subtitle;
  final Widget widget;
  final IconButtonRectangular icon;
  final List<IconButtonRetangularType> services;
  final double rating;

  ServiceViewData({
    required this.title,
    required this.subtitle,
    required this.widget,
    required this.icon,
    required this.services,
    required this.rating,
  });
}

ServiceViewData serviceView = ServiceViewData(
  title: "Título do Cartão 1",
  subtitle: "Subtítulo do Cartão 1",
  widget: const PresentImage(
    path: AssetImage("assets/default_avatar.png"),
  ),
  icon: const IconButtonRectangular(
    dimension: 50,
    object: Icon(Icons.store_mall_directory_outlined),
  ),
  services: [
    IconButtonRetangularType.iron,
    IconButtonRetangularType.dry,
    IconButtonRetangularType.recycle,
    IconButtonRetangularType.repair,
    IconButtonRetangularType.wash
  ],
  rating: 3,
);

class Store {
  final String name;
  final String serviceProvider;
  final Widget image;

  Store(
      {required this.name, required this.serviceProvider, required this.image});
}

List<Store> stores = [
  Store(
      image: const IconButtonRectangular(
        isCircular: true,
        dimension: 50,
        object: Icon(Icons.store_mall_directory_outlined),
      ),
      name: "Nome da Loja 1",
      serviceProvider: "Serviços Prestados"),
  Store(
      image: const IconButtonRectangular(
        isCircular: true,
        dimension: 50,
        object: Icon(Icons.store_mall_directory_outlined),
      ),
      name: "Nome da Loja 2",
      serviceProvider: "Serviços Prestados"),
  Store(
      image: const IconButtonRectangular(
        isCircular: true,
        dimension: 50,
        object: Icon(Icons.store_mall_directory_outlined),
      ),
      name: "Nome da Loja 3",
      serviceProvider: "Serviços Prestados"),
];
