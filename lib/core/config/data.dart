import 'package:beat_ecoprove/core/widgets/present_image.dart';
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
