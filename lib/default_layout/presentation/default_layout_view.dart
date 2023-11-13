import 'package:beat_ecoprove/clothing/presentation/clothing_view.dart';
import 'package:beat_ecoprove/clothing/presentation/info_cloth/info_cloth_view.dart';
import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/widgets/footer/footer.dart';
import 'package:beat_ecoprove/core/widgets/headers/header.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view.dart';
import 'package:flutter/material.dart';

class DefaultLayoutView extends StatelessWidget {
  final Header header;

  const DefaultLayoutView({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header,
      body: PageView(
        children: [
          InfoClothView(
            card: clothItems[2].toCardItem(),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
