import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class CardData {
  final String title;
  final String subtitle;
  final Widget widget;

  CardData({required this.title, required this.subtitle, required this.widget});
}

List<CardData> cards = [
  CardData(
    title: "Título do Cartão 1",
    subtitle: "Subtítulo do Cartão 1",
    widget: Image.asset(
      "assets/default_avatar.png",
      fit: BoxFit.cover,
      alignment: Alignment.center,
    ),
  ),
  CardData(
    title: "Título do Cartão 2",
    subtitle: "Subtítulo do Cartão 2",
    widget: Image.asset(
      "assets/default_avatar.png",
      fit: BoxFit.cover,
      alignment: Alignment.center,
    ),
  ),
  CardData(
    title: "Título do Cartão 3",
    subtitle: "Subtítulo do Cartão 3",
    widget: Image.asset(
      "assets/default_avatar.png",
      fit: BoxFit.cover,
      alignment: Alignment.center,
    ),
  ),
  CardData(
    title: "Título do Cartão 4",
    subtitle: "Subtítulo do Cartão 4",
    widget: Image.asset(
      "assets/default_avatar.png",
      fit: BoxFit.cover,
      alignment: Alignment.center,
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
    title: "Título do Cartão 1",
    subtitle: "Subtítulo do Cartão 1",
    widget: const Icon(Icons.image),
  ),
  ServiceData(
    title: "Título do Cartão 2",
    subtitle: "Subtítulo do Cartão 2",
    widget: const Icon(Icons.image),
  ),
  ServiceData(
    title: "Título do Cartão 3",
    subtitle: "Subtítulo do Cartão 3",
    widget: const Icon(Icons.image),
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
  widget: Image.asset(
    "assets/default_avatar.png",
    fit: BoxFit.cover,
    alignment: Alignment.center,
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

class User {
  final String path;
  final String name; //Max: 18
  final double percent;
  final int level;

  User({
    this.path = "assets/default_avatar.png",
    this.name = "Diogo Assunção",
    this.percent = 78.5,
    this.level = 1,
  });
}

User user = User();
