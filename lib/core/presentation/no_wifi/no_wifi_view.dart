import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/presentation/no_wifi/no_wifi_view_model.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class NoWifiView extends LinearView<NoWifiViewModel> {
  const NoWifiView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, NoWifiViewModel viewModel) {
    double gapHeight = (MediaQuery.of(context).size.height / 4) - 24;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
          content: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: gapHeight,
                        ),
                        SizedBox(
                          height: gapHeight * 2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: (gapHeight / 3) - 16,
                              ),
                              const Text(
                                "Sem Internet!",
                                style: AppText.header,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SvgImage(
                                path: "assets/nowifi.svg",
                                height: 172,
                                width: 172,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: gapHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          type: AppBackgrounds.login),
    );
  }
}
