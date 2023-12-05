import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
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
    title: "Título do Cartão 1",
    subtitle: "Subtítulo do Cartão 1",
    widget: const PresentImage(
      path: AssetImage("assets/default_avatar.png"),
    ),
  ),
  CardData(
    title: "Título do Cartão 2",
    subtitle: "Subtítulo do Cartão 2",
    widget: const PresentImage(
      path: AssetImage("assets/default_avatar.png"),
    ),
  ),
  CardData(
    title: "Título do Cartão 3",
    subtitle: "Subtítulo do Cartão 3",
    widget: const PresentImage(
      path: AssetImage("assets/default_avatar.png"),
    ),
  ),
  CardData(
    title: "Título do Cartão 4",
    subtitle: "Subtítulo do Cartão 4",
    widget: const PresentImage(
      path: AssetImage("assets/default_avatar.png"),
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

Map<String, String> clothes = {
  "jeans": "Calças",
  "jackets": "Casacos",
  "t_shirt": "T-shirts",
  "shirts": "Camisas",
  "skirts": "Saias",
};

class Filter {
  final String text;
  final Widget? content;
  final double dimension;
  final Color? color;
  final String value;

  Filter({
    required this.text,
    this.content,
    this.dimension = 40,
    this.color,
    required this.value,
  });

  FilterButtonItem toFilterButton() {
    return FilterButtonItem(
        text: text,
        content: content,
        dimension: dimension,
        backgroundColor: color,
        value: value);
  }
}

class RowFilter {
  final List<Filter> options;
  final String? title;
  final bool isCircular;

  RowFilter({
    required this.options,
    this.title,
    this.isCircular = false,
  });

  FilterRow toFilterRow() {
    return FilterRow(
        title: title,
        isCircular: isCircular,
        options: options.map((option) {
          return option.toFilterButton();
        }).toList());
  }
}

List<RowFilter> optionsToFilter = [
  RowFilter(
    title: "Tamanho",
    options: [
      Filter(
        text: "size_xs",
        content: const Text(
          "XS",
          style: AppText.smallHeader,
        ),
        value: "xs",
      ),
      Filter(
        text: "size_s",
        content: const Text(
          "S",
          style: AppText.smallHeader,
        ),
        value: "s",
      ),
      Filter(
        text: "size_m",
        content: const Text(
          "M",
          style: AppText.smallHeader,
        ),
        value: "m",
      ),
      Filter(
        text: "size_l",
        content: const Text(
          "L",
          style: AppText.smallHeader,
        ),
        value: "l",
      ),
      Filter(
        text: "size_xl",
        content: const Text(
          "XL",
          style: AppText.smallHeader,
        ),
        value: "xl",
      ),
      Filter(
        text: "size_xxl",
        content: const Text(
          "XXL",
          style: AppText.smallHeader,
        ),
        value: "xxl",
      ),
    ],
  ),
  RowFilter(
    title: "Cor",
    isCircular: true,
    options: [
      Filter(
        text: "color_yellow",
        dimension: 30,
        color: const Color.fromRGBO(255, 230, 159, 1),
        value: "FFFFFFE69F",
      ),
      Filter(
        text: "color_light_blue",
        dimension: 30,
        color: const Color.fromRGBO(152, 179, 200, 1),
        value: "FF98B3C8",
      ),
      Filter(
        text: "color_dark_blue",
        dimension: 30,
        color: const Color.fromRGBO(41, 57, 74, 1),
        value: "FF29394A",
      ),
      Filter(
        text: "color_super_light_yellow",
        dimension: 30,
        color: const Color.fromRGBO(242, 231, 212, 1),
        value: "FFF2E7D4",
      ),
      Filter(
        text: "color_light_yellow",
        dimension: 30,
        color: const Color.fromRGBO(195, 165, 114, 1),
        value: "FFC3A572",
      ),
      Filter(
        text: "color_light_red",
        dimension: 30,
        color: const Color.fromRGBO(255, 109, 109, 1),
        value: "FFFF6D6D",
      ),
      Filter(
        text: "color_white",
        dimension: 30,
        color: const Color.fromRGBO(255, 255, 255, 1),
        value: "FFFFFFFF",
      ),
      Filter(
        text: "color_light_brown",
        dimension: 30,
        color: const Color.fromRGBO(148, 128, 102, 1),
        value: "FF948066",
      ),
      Filter(
        text: "color_brown",
        dimension: 30,
        color: const Color.fromRGBO(74, 45, 22, 1),
        value: "FF4A2D16",
      ),
      Filter(
        text: "color_light_grey",
        dimension: 30,
        color: const Color.fromRGBO(76, 76, 76, 1),
        value: "FF4C4C4C",
      ),
      Filter(
        text: "color_pink",
        dimension: 30,
        color: const Color.fromRGBO(190, 89, 103, 1),
        value: "FFBE5967",
      ),
      Filter(
        text: "color_super_light_brown",
        dimension: 30,
        color: const Color.fromRGBO(139, 95, 60, 1),
        value: "FF8B5F3C",
      ),
      Filter(
        text: "color_orange",
        dimension: 30,
        color: const Color.fromRGBO(245, 130, 33, 1),
        value: "FFF58221",
      ),
      Filter(
        text: "color_light_purple",
        dimension: 30,
        color: const Color.fromRGBO(210, 170, 197, 1),
        value: "FFD2AAC5",
      ),
      Filter(
        text: "color_super_light_grey",
        dimension: 30,
        color: const Color.fromRGBO(192, 192, 192, 1),
        value: "FFC0C0C0",
      ),
      Filter(
        text: "color_black",
        dimension: 30,
        color: const Color.fromRGBO(0, 0, 0, 1),
        value: "FF000000",
      ),
      Filter(
        text: "color_light_pink",
        dimension: 30,
        color: const Color.fromRGBO(249, 199, 196, 1),
        value: "FFF9C7C4",
      ),
      Filter(
        text: "color_purple",
        dimension: 30,
        color: const Color.fromRGBO(214, 37, 152, 1),
        value: "FFD62598",
      ),
      Filter(
        text: "color_green",
        dimension: 30,
        color: const Color.fromRGBO(80, 156, 117, 1),
        value: "FF509C75",
      ),
      Filter(
        text: "color_lime",
        dimension: 30,
        color: const Color.fromRGBO(194, 188, 139, 1),
        value: "FFC2BC8B",
      ),
      Filter(
        text: "color_red",
        dimension: 30,
        color: const Color.fromRGBO(218, 37, 46, 1),
        value: "FFDA252E",
      ),
    ],
  ),
  RowFilter(
    title: "Marca",
    options: [
      Filter(
        text: "brand_salsa",
        content: const PresentImage(path: AssetImage("assets/salsa.png")),
        value: "salsa",
      ),
    ],
  ),
  RowFilter(
    title: "Ordenar Por",
    options: [
      Filter(
        text: "order_az",
        content: const Text(
          "Az",
          style: AppText.smallHeader,
        ),
        value: "abc asc",
      ),
      Filter(
        text: "order_za",
        content: const Text(
          "Za",
          style: AppText.smallHeader,
        ),
        value: "abc desc",
      ),
      Filter(
        text: "order_desc",
        content: const SvgImage(
          path: "assets/filter/time_desc.svg",
          color: AppColor.black,
          height: 20,
          width: 20,
        ),
        value: "order time desc",
      ),
      Filter(
        text: "order_asc",
        content: const SvgImage(
          path: "assets/filter/time_asc.svg",
          color: AppColor.black,
          height: 20,
          width: 20,
        ),
        value: "order time asc",
      ),
      Filter(
        text: "order_bucket",
        content: const SvgImage(
          path: "assets/services/bucket.svg",
          color: AppColor.black,
          height: 15,
          width: 15,
        ),
        value: "bucket",
      ),
    ],
  ),
  RowFilter(
    title: "Perfis",
    options: [
      Filter(
        text: "profile_1",
        content:
            const PresentImage(path: AssetImage("assets/default_avatar.png")),
        value: "profile 1",
      ),
    ],
  ),
];
