import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
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

class User {
  final String path;
  final String name; //Max: 18
  final double percent;
  final int level;
  final int sustainablePoints;

  User({
    required this.path,
    required this.name,
    required this.percent,
    required this.level,
    required this.sustainablePoints,
  });
}

User user = User(
  path: "assets/default_avatar.png",
  level: 1,
  name: "Diogo Assunção",
  percent: 79,
  sustainablePoints: 100,
);

class Clothing {
  final String typeOfCloth;
  final bool isSelected;

  Clothing({
    required this.typeOfCloth,
    this.isSelected = false,
  });
}

List<Clothing> clothes = [
  Clothing(
    typeOfCloth: "Tudo",
    isSelected: true,
  ),
  Clothing(
    typeOfCloth: "Calças",
  ),
  Clothing(
    typeOfCloth: "Casacos",
  ),
  Clothing(
    typeOfCloth: "T-shirts",
  ),
  Clothing(
    typeOfCloth: "Camisas",
  ),
  Clothing(
    typeOfCloth: "Saias",
  ),
];

abstract class Item {
  final String title;
  final String? subTitle;
  final ImageProvider? otherProfileImage;

  Item({
    required this.title,
    this.subTitle,
    this.otherProfileImage,
  });

  dynamic toItemModel();
}

class ClothItem extends Item {
  final ImageProvider content;

  ClothItem({
    required this.content,
    required super.title,
    super.subTitle,
    super.otherProfileImage,
  });

  @override
  ImageProvider toItemModel() {
    return content;
  }
}

class BucketItem extends Item {
  final List<ClothItem> list;

  BucketItem({
    required this.list,
    required super.title,
    super.subTitle,
    super.otherProfileImage,
  });

  @override
  List<CardItemModel> toItemModel() {
    return list.map((item) {
      return CardItemModel(
        title: item.title,
        subTitle: item.subTitle,
        image: item.content,
      );
    }).toList();
  }
}

List<Item> clothItems = [
  ClothItem(
    title: "T-Shirt",
    subTitle: "Nike",
    content: const AssetImage("assets/default_avatar.png"),
    otherProfileImage: const AssetImage("assets/default_avatar.png"),
  ),
  ClothItem(
    title: "T-Shirt",
    subTitle: "Nike",
    content: const AssetImage("assets/default_avatar.png"),
  ),
  BucketItem(
    list: [
      ClothItem(
        title: "T-Shirt",
        subTitle: "Nike",
        content: const AssetImage("assets/default_avatar.png"),
        otherProfileImage: const AssetImage("assets/default_avatar.png"),
      ),
      ClothItem(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
      ),
    ],
    title: "Cesto",
  ),
  BucketItem(
    list: [
      ClothItem(
        title: "T-Shirt",
        subTitle: "Nike",
        content: const AssetImage("assets/default_avatar.png"),
      ),
      ClothItem(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
      ),
      ClothItem(
        title: "T-Shirt",
        subTitle: "Nike",
        content: const AssetImage("assets/default_avatar.png"),
      ),
      ClothItem(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
        otherProfileImage: const AssetImage("assets/default_avatar.png"),
      ),
    ],
    title: "Cesto",
  ),
  BucketItem(
    list: [
      ClothItem(
        title: "T-Shirt Adidas",
        content: const AssetImage("assets/default_avatar.png"),
      ),
    ],
    title: "Cesto",
  ),
];

class FilterButtonItem {
  final String text;
  final Widget content;
  final bool isCircular;
  final double dimension;

  FilterButtonItem({
    required this.text,
    required this.content,
    this.isCircular = false,
    this.dimension = 40,
  });
}

class RowFilter {
  final List<FilterButtonItem> options;
  final String title;

  RowFilter({
    required this.options,
    required this.title,
  });
}

List<RowFilter> optionsToFilter = [
  RowFilter(
    title: "Tamanho",
    options: [
      FilterButtonItem(
        text: "size_xs",
        content: const Text(
          "XS",
          style: AppText.smallHeader,
        ),
      ),
      FilterButtonItem(
        text: "size_s",
        content: const Text(
          "S",
          style: AppText.smallHeader,
        ),
      ),
      FilterButtonItem(
        text: "size_m",
        content: const Text(
          "M",
          style: AppText.smallHeader,
        ),
      ),
      FilterButtonItem(
        text: "size_l",
        content: const Text(
          "L",
          style: AppText.smallHeader,
        ),
      ),
      FilterButtonItem(
        text: "size_xl",
        content: const Text(
          "XL",
          style: AppText.smallHeader,
        ),
      ),
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
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
      FilterButtonItem(
        text: "brand_salsa",
        content: const PresentImage(path: AssetImage("assets/salsa.png")),
      ),
    ],
  ),
  RowFilter(
    title: "Ordenar Por",
    options: [
      FilterButtonItem(
        text: "order_az",
        content: const Text(
          "Az",
          style: AppText.smallHeader,
        ),
      ),
      FilterButtonItem(
        text: "order_za",
        content: const Text(
          "Za",
          style: AppText.smallHeader,
        ),
      ),
      FilterButtonItem(
        text: "order_desc",
        content: const SvgImage(
          path: "assets/filter/time_desc.svg",
          color: AppColor.black,
          height: 20,
          width: 20,
        ),
      ),
      FilterButtonItem(
        text: "order_asc",
        content: const SvgImage(
          path: "assets/filter/time_asc.svg",
          color: AppColor.black,
          height: 20,
          width: 20,
        ),
      ),
      FilterButtonItem(
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
      FilterButtonItem(
        text: "profile_1",
        content:
            const PresentImage(path: AssetImage("assets/default_avatar.png")),
      ),
    ],
  ),
];
