import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
import 'package:beat_ecoprove/core/widgets/filter/wrap_filter_options.dart';
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

List<WrapFilterOptions> optionsToFilter = [
  const WrapFilterOptions(
    title: "Tamanho",
    filterOptions: [
      IconButtonRectangular(
        object: Text(
          "XS",
          style: AppText.smallHeader,
        ),
      ),
      IconButtonRectangular(
        object: Text(
          "S",
          style: AppText.smallHeader,
        ),
      ),
      IconButtonRectangular(
        object: Text(
          "M",
          style: AppText.smallHeader,
        ),
      ),
      IconButtonRectangular(
        object: Text(
          "L",
          style: AppText.smallHeader,
        ),
      ),
      IconButtonRectangular(
        object: Text(
          "XL",
          style: AppText.smallHeader,
        ),
      ),
      IconButtonRectangular(
        object: Text(
          "XXL",
          style: AppText.smallHeader,
        ),
      ),
    ],
  ),
  WrapFilterOptions(
    title: "Cor",
    filterOptions: [
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 230, 159, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(152, 179, 200, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(41, 57, 74, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(242, 231, 212, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(195, 165, 114, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 109, 109, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(148, 128, 102, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(74, 45, 22, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(76, 76, 76, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(190, 89, 103, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(139, 95, 60, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(245, 130, 33, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(210, 170, 197, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(192, 192, 192, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(249, 199, 196, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(214, 37, 152, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(80, 156, 117, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(194, 188, 139, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
      IconButtonRectangular(
        isCircular: true,
        dimension: 30,
        object: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(218, 37, 46, 1),
            shape: BoxShape.circle,
            boxShadow: [AppColor.defaultShadow],
          ),
        ),
      ),
    ],
  ),
  const WrapFilterOptions(
    title: "Marca",
    filterOptions: [
      IconButtonRectangular(
        object: PresentImage(path: AssetImage("assets/salsa.png")),
      ),
    ],
  ),
  const WrapFilterOptions(
    title: "Ordenar Por",
    filterOptions: [
      IconButtonRectangular(
        object: Text(
          "Az",
          style: AppText.smallHeader,
        ),
      ),
      IconButtonRectangular(
        object: Text(
          "Za",
          style: AppText.smallHeader,
        ),
      ),
      IconButtonRectangular(
        object: SvgImage(
          path: "assets/filter/time_desc.svg",
          height: 20,
          width: 20,
        ),
      ),
      IconButtonRectangular(
        object: SvgImage(
          path: "assets/filter/time_asc.svg",
          height: 20,
          width: 20,
        ),
      ),
      IconButtonRectangular(
        object: SvgImage(
          path: "assets/filter/bucket_black.svg",
          height: 15,
          width: 15,
        ),
      ),
    ],
  ),
  const WrapFilterOptions(
    title: "Perfis",
    filterOptions: [
      IconButtonRectangular(
        object: PresentImage(path: AssetImage("assets/default_avatar.png")),
      ),
    ],
  ),
];
