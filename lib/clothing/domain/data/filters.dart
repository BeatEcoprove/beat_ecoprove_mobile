import 'package:beat_ecoprove/clothing/domain/models/row_filter.dart';
import 'package:beat_ecoprove/clothing/domain/models/filter.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

Map<String, String> clothes = {
  "jeans": "Calças",
  "jackets": "Casacos",
  "tshirt": "T-shirts",
  "shirts": "Camisas",
  "skirts": "Saias",
};

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
        tag: "size",
      ),
      Filter(
        text: "size_s",
        content: const Text(
          "S",
          style: AppText.smallHeader,
        ),
        value: "s",
        tag: "size",
      ),
      Filter(
        text: "size_m",
        content: const Text(
          "M",
          style: AppText.smallHeader,
        ),
        value: "m",
        tag: "size",
      ),
      Filter(
        text: "size_l",
        content: const Text(
          "L",
          style: AppText.smallHeader,
        ),
        value: "l",
        tag: "size",
      ),
      Filter(
        text: "size_xl",
        content: const Text(
          "XL",
          style: AppText.smallHeader,
        ),
        value: "xl",
        tag: "size",
      ),
      Filter(
        text: "size_xxl",
        content: const Text(
          "XXL",
          style: AppText.smallHeader,
        ),
        value: "xxl",
        tag: "size",
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
        value: "FFFFE69F",
        tag: "color",
      ),
      Filter(
        text: "color_light_blue",
        dimension: 30,
        color: const Color.fromRGBO(152, 179, 200, 1),
        value: "FF98B3C8",
        tag: "color",
      ),
      Filter(
        text: "color_dark_blue",
        dimension: 30,
        color: const Color.fromRGBO(41, 57, 74, 1),
        value: "FF29394A",
        tag: "color",
      ),
      Filter(
        text: "color_super_light_yellow",
        dimension: 30,
        color: const Color.fromRGBO(242, 231, 212, 1),
        value: "FFF2E7D4",
        tag: "color",
      ),
      Filter(
        text: "color_light_yellow",
        dimension: 30,
        color: const Color.fromRGBO(195, 165, 114, 1),
        value: "FFC3A572",
        tag: "color",
      ),
      Filter(
        text: "color_light_red",
        dimension: 30,
        color: const Color.fromRGBO(255, 109, 109, 1),
        value: "FFFF6D6D",
        tag: "color",
      ),
      Filter(
        text: "color_white",
        dimension: 30,
        color: const Color.fromRGBO(255, 255, 255, 1),
        value: "FFFFFFFF",
        tag: "color",
      ),
      Filter(
        text: "color_light_brown",
        dimension: 30,
        color: const Color.fromRGBO(148, 128, 102, 1),
        value: "FF948066",
        tag: "color",
      ),
      Filter(
        text: "color_brown",
        dimension: 30,
        color: const Color.fromRGBO(74, 45, 22, 1),
        value: "FF4A2D16",
        tag: "color",
      ),
      Filter(
        text: "color_light_grey",
        dimension: 30,
        color: const Color.fromRGBO(76, 76, 76, 1),
        value: "FF4C4C4C",
        tag: "color",
      ),
      Filter(
        text: "color_pink",
        dimension: 30,
        color: const Color.fromRGBO(190, 89, 103, 1),
        value: "FFBE5967",
        tag: "color",
      ),
      Filter(
        text: "color_super_light_brown",
        dimension: 30,
        color: const Color.fromRGBO(139, 95, 60, 1),
        value: "FF8B5F3C",
        tag: "color",
      ),
      Filter(
        text: "color_orange",
        dimension: 30,
        color: const Color.fromRGBO(245, 130, 33, 1),
        value: "FFF58221",
        tag: "color",
      ),
      Filter(
        text: "color_light_purple",
        dimension: 30,
        color: const Color.fromRGBO(210, 170, 197, 1),
        value: "FFD2AAC5",
        tag: "color",
      ),
      Filter(
        text: "color_super_light_grey",
        dimension: 30,
        color: const Color.fromRGBO(192, 192, 192, 1),
        value: "FFC0C0C0",
        tag: "color",
      ),
      Filter(
        text: "color_black",
        dimension: 30,
        color: const Color.fromRGBO(0, 0, 0, 1),
        value: "FF000000",
        tag: "color",
      ),
      Filter(
        text: "color_light_pink",
        dimension: 30,
        color: const Color.fromRGBO(249, 199, 196, 1),
        value: "FFF9C7C4",
        tag: "color",
      ),
      Filter(
        text: "color_purple",
        dimension: 30,
        color: const Color.fromRGBO(214, 37, 152, 1),
        value: "FFD62598",
        tag: "color",
      ),
      Filter(
        text: "color_green",
        dimension: 30,
        color: const Color.fromRGBO(80, 156, 117, 1),
        value: "FF509C75",
        tag: "color",
      ),
      Filter(
        text: "color_lime",
        dimension: 30,
        color: const Color.fromRGBO(194, 188, 139, 1),
        value: "FFC2BC8B",
        tag: "color",
      ),
      Filter(
        text: "color_red",
        dimension: 30,
        color: const Color.fromRGBO(218, 37, 46, 1),
        value: "FFDA252E",
        tag: "color",
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
        tag: "brand",
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
        tag: "sortBy",
      ),
      Filter(
        text: "order_za",
        content: const Text(
          "Za",
          style: AppText.smallHeader,
        ),
        value: "abc desc",
        tag: "sortBy",
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
        tag: "sortBy",
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
        tag: "sortBy",
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
        tag: "sortBy",
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
        tag: "profileId",
      ),
    ],
  ),
];
