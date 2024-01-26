import 'package:beat_ecoprove/clothing/domain/models/row_filter.dart';
import 'package:beat_ecoprove/clothing/domain/models/filter.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

Map<String, String> clothes = {
  "jeans": "Calças",
  "jackets": "Casacos",
  "tshirts": "T-shirts",
  "shirts": "Camisas",
  "skirts": "Saias",
};

List<RowFilter> optionsToFilter = [
  RowFilter(
    title: "Tamanho",
    options: [
      Filter(
        text: "size_xs",
        content: const Center(
          child: Text(
            "XS",
            style: AppText.smallHeader,
          ),
        ),
        value: "xs",
        tag: "size",
      ),
      Filter(
        text: "size_s",
        content: const Center(
          child: Text(
            "S",
            style: AppText.smallHeader,
          ),
        ),
        value: "s",
        tag: "size",
      ),
      Filter(
        text: "size_m",
        content: const Center(
          child: Text(
            "M",
            style: AppText.smallHeader,
          ),
        ),
        value: "m",
        tag: "size",
      ),
      Filter(
        text: "size_l",
        content: const Center(
          child: Text(
            "L",
            style: AppText.smallHeader,
          ),
        ),
        value: "l",
        tag: "size",
      ),
      Filter(
        text: "size_xl",
        content: const Center(
          child: Text(
            "XL",
            style: AppText.smallHeader,
          ),
        ),
        value: "xl",
        tag: "size",
      ),
      Filter(
        text: "size_xxl",
        content: const Center(
          child: Text(
            "XXL",
            style: AppText.smallHeader,
          ),
        ),
        value: "xxl",
        tag: "size",
      ),
    ],
  ),
  // RowFilter(
  //   title: "Ordenar Por",
  //   options: [
  //     Filter(
  //       text: "order_az",
  //       content: const Text(
  //         "Az",
  //         style: AppText.smallHeader,
  //       ),
  //       value: "abc asc",
  //       tag: "sortBy",
  //     ),
  //     Filter(
  //       text: "order_za",
  //       content: const Text(
  //         "Za",
  //         style: AppText.smallHeader,
  //       ),
  //       value: "abc desc",
  //       tag: "sortBy",
  //     ),
  //     Filter(
  //       text: "order_desc",
  //       content: const SvgImage(
  //         path: "assets/filter/time_desc.svg",
  //         color: AppColor.black,
  //         height: 20,
  //         width: 20,
  //       ),
  //       value: "order time desc",
  //       tag: "sortBy",
  //     ),
  //     Filter(
  //       text: "order_asc",
  //       content: const SvgImage(
  //         path: "assets/filter/time_asc.svg",
  //         color: AppColor.black,
  //         height: 20,
  //         width: 20,
  //       ),
  //       value: "order time asc",
  //       tag: "sortBy",
  //     ),
  //     Filter(
  //       text: "order_bucket",
  //       content: const SvgImage(
  //         path: "assets/services/bucket.svg",
  //         color: AppColor.black,
  //         height: 15,
  //         width: 15,
  //       ),
  //       value: "bucket",
  //       tag: "sortBy",
  //     ),
  //   ],
  // ),
];
