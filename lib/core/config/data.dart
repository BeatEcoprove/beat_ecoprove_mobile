import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
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

class NotUser {
  final String path;
  final String name; //Max: 18
  final double percent;
  final int level;
  final int sustainablePoints;

  NotUser({
    required this.path,
    required this.name,
    required this.percent,
    required this.level,
    required this.sustainablePoints,
  });
}

NotUser notUser = NotUser(
  path: "assets/default_avatar.png",
  level: 1,
  name: "Diogo Assunção",
  percent: 79,
  sustainablePoints: 100,
);

Map<String, String> clothes = {
  "jeans": "Calças",
  "jackets": "Casacos",
  "t_shirt": "T-shirts",
  "shirts": "Camisas",
  "skirts": "Saias",
};

abstract class Item {
  final String title;
  final String? subTitle;
  final ImageProvider? otherProfileImage;

  Item({
    required this.title,
    this.subTitle,
    this.otherProfileImage,
  });

  CardItem toCardItem();
}

class Cloth extends Item {
  final ImageProvider content;
  final String size;
  final Color color;
  final int ecoScore;
  final String brand;

  Cloth({
    required this.content,
    required super.title,
    super.subTitle,
    super.otherProfileImage,
    required this.size,
    required this.color,
    required this.ecoScore,
    required this.brand,
  });

  @override
  CardItem toCardItem() {
    return CardItem(
      title: title,
      subTitle: subTitle,
      child: content,
      hasProfile: otherProfileImage,
      size: size,
      color: color,
      ecoScore: ecoScore,
      brand: brand,
    );
  }
}

class Bucket extends Item {
  final List<Cloth> list;

  Bucket({
    required this.list,
    required super.title,
    super.subTitle,
    super.otherProfileImage,
  });

  @override
  CardItem toCardItem() {
    return CardItem(
      title: title,
      child: list.map((item) {
        return CardItem(
          title: item.title,
          subTitle: item.subTitle,
          child: item.content,
        );
      }).toList(),
    );
  }
}

List<Item> clothItems = [
  Cloth(
    title: "T-Shirt",
    subTitle: "Nike",
    content: const AssetImage("assets/default_avatar.png"),
    otherProfileImage: const AssetImage("assets/default_avatar.png"),
    brand: "Nike",
    color: Color(0xFF1F1F1F),
    ecoScore: 100,
    size: 'M',
  ),
  Cloth(
    title: "T-Shirt",
    subTitle: "Nike",
    content: const AssetImage("assets/default_avatar.png"),
    brand: "Nike",
    color: Color(0xFF1F1F1F),
    ecoScore: 50,
    size: 'XL',
  ),
  Cloth(
    title: "T-Shirt Adidas",
    content: const AssetImage("assets/default_avatar.png"),
    brand: "Adidas",
    color: Color(0xFF811A1F),
    ecoScore: 50,
    size: 'XL',
  ),
  Bucket(
    list: [
      Cloth(
        title: "T-Shirt",
        subTitle: "Nike",
        content: const AssetImage("assets/default_avatar.png"),
        otherProfileImage: const AssetImage("assets/default_avatar.png"),
        brand: "Nike",
        color: Color(0xFF1FA4A2),
        ecoScore: 50,
        size: 'XL',
      ),
      Cloth(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
        brand: "Adidas",
        color: Color(0xFF1FA91F),
        ecoScore: 75,
        size: 'L',
      ),
    ],
    title: "Cesto",
  ),
  Bucket(
    list: [
      Cloth(
        title: "T-Shirt",
        subTitle: "Nike",
        content: const AssetImage("assets/default_avatar.png"),
        brand: "Nike",
        color: Color(0xFF1F1BC2),
        ecoScore: 50,
        size: 'XXL',
      ),
      Cloth(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
        brand: "Adidas",
        color: Color(0xFF811A1F),
        ecoScore: 50,
        size: 'XL',
      ),
      Cloth(
        title: "T-Shirt",
        subTitle: "Nike",
        content: const AssetImage("assets/default_avatar.png"),
        brand: "Nike",
        color: Color(0xFF1F1F1F),
        ecoScore: 50,
        size: 'M',
      ),
      Cloth(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
        otherProfileImage: const AssetImage("assets/default_avatar.png"),
        brand: "Adidas",
        color: Color(0xFF1FCD1F),
        ecoScore: 150,
        size: 'L',
      ),
    ],
    title: "Cesto",
  ),
  Bucket(
    list: [
      Cloth(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
        brand: "Nike",
        color: Color(0xFF1F1F1F),
        ecoScore: 50,
        size: 'XL',
      ),
    ],
    title: "Cesto",
  ),
];

class Filter {
  final String text;
  final Widget content;
  final bool isCircular;
  final double dimension;

  Filter({
    required this.text,
    required this.content,
    this.isCircular = false,
    this.dimension = 40,
  });

  FilterButtonItem toFilterButton() {
    return FilterButtonItem(
        text: text,
        content: content,
        isCircular: isCircular,
        dimension: dimension);
  }
}

class RowFilter {
  final List<Filter> options;
  final String title;

  RowFilter({
    required this.options,
    required this.title,
  });

  FilterRow toFilterRow() {
    return FilterRow(
        title: title,
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
      ),
      Filter(
        text: "size_s",
        content: const Text(
          "S",
          style: AppText.smallHeader,
        ),
      ),
      Filter(
        text: "size_m",
        content: const Text(
          "M",
          style: AppText.smallHeader,
        ),
      ),
      Filter(
        text: "size_l",
        content: const Text(
          "L",
          style: AppText.smallHeader,
        ),
      ),
      Filter(
        text: "size_xl",
        content: const Text(
          "XL",
          style: AppText.smallHeader,
        ),
      ),
      Filter(
        text: "size_xxl",
        content: const Text(
          "XXL",
          style: AppText.smallHeader,
        ),
      ),
    ],
  ),
  RowFilter(
    title: "Cor",
    options: [
      Filter(
        text: "color_yellow",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 230, 159, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_light_blue",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(152, 179, 200, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_dark_blue",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(41, 57, 74, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_super_light_yellow",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(242, 231, 212, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_light_yellow",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(195, 165, 114, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_light_red",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 109, 109, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_white",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_light_brown",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(148, 128, 102, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_brown",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(74, 45, 22, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_light_grey",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(76, 76, 76, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_pink",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(190, 89, 103, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_super_light_brown",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(139, 95, 60, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_orange",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(245, 130, 33, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_light_purple",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(210, 170, 197, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_super_light_grey",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(192, 192, 192, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_black",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_light_pink",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(249, 199, 196, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_purple",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(214, 37, 152, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_green",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(80, 156, 117, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_lime",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(194, 188, 139, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      Filter(
        text: "color_red",
        dimension: 30,
        isCircular: true,
        content: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(218, 37, 46, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
    ],
  ),
  RowFilter(
    title: "Marca",
    options: [
      Filter(
        text: "brand_salsa",
        content: const PresentImage(path: AssetImage("assets/salsa.png")),
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
      ),
      Filter(
        text: "order_za",
        content: const Text(
          "Za",
          style: AppText.smallHeader,
        ),
      ),
      Filter(
        text: "order_desc",
        content: const SvgImage(
          path: "assets/filter/time_desc.svg",
          color: AppColor.black,
          height: 20,
          width: 20,
        ),
      ),
      Filter(
        text: "order_asc",
        content: const SvgImage(
          path: "assets/filter/time_asc.svg",
          color: AppColor.black,
          height: 20,
          width: 20,
        ),
      ),
      Filter(
        text: "order_bucket",
        content: const SvgImage(
          path: "assets/services/bucket.svg",
          color: AppColor.black,
          height: 15,
          width: 15,
        ),
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
      ),
    ],
  ),
];
