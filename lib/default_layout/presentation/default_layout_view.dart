import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/clothing/presentation/clothing_view.dart';
import 'package:beat_ecoprove/core/widgets/footer/footer.dart';
import 'package:beat_ecoprove/core/widgets/headers/header.dart';
import 'package:beat_ecoprove/core/widgets/headers/headers.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_view.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view.dart';
import 'package:flutter/material.dart';

class DefaultLayoutView extends StatelessWidget {
  final Headers header;

  const DefaultLayoutView({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(content: header),
      body: PageView(
        children: const [
          ClothingView(),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
