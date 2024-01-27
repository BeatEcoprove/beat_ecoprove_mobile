import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:flutter/material.dart';

class ListDetailsViewParams {
  late Widget searchBar;
  final String title;
  late List<Widget> list;

  ListDetailsViewParams({
    required this.searchBar,
    required this.title,
    required this.list,
  });
}

class ListDetailsView extends StatelessWidget {
  final ListDetailsViewParams params;

  const ListDetailsView({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.registerClothBackground1,
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Text(
                          params.title,
                          style: AppText.alternativeHeader,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        params.searchBar,
                        const SizedBox(
                          height: 26,
                        ),
                        Column(
                          children: params.list,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
