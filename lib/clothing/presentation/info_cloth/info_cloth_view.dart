import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/place_to_place.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/rounded_button.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/sustainable_points.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class InfoClothView extends StatelessWidget {
  const InfoClothView({super.key});

  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(25);

    return Scaffold(
      body: FutureBuilder(
        future: _updatePaletteGenerator(),
        builder:
            (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
          double maxWidth = MediaQuery.of(context).size.width;

          return GoBack(
            posTop: 18,
            posLeft: 18,
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: snapshot.data?.lightVibrantColor?.color,
              child: Stack(
                children: [
                  const Positioned(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 257,
                      child: Center(
                        widthFactor: 257,
                        child: PresentImage(
                          path: AssetImage("assets/sueter.png"),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 24,
                    top: 180,
                    child: IconButtonRectangular(
                      dimension: 50,
                      object: PresentImage(
                        path: AssetImage("assets/default_avatar.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    right: 28,
                    child: IconButton(
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: AppColor.widgetSecondary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    right: 28,
                    top: 185,
                    child: RoundedButton(
                      onAction: () {},
                    ),
                  ),
                  Positioned(
                    top: 237,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 24,
                      ),
                      width: maxWidth,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: borderRadius,
                          topRight: borderRadius,
                        ),
                        color: AppColor.widgetBackground,
                        boxShadow: [AppColor.defaultShadow],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Camisola Preta",
                                      style: AppText.smallHeader,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Salsa",
                                      style: AppText.subHeader,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Eco-Score",
                                      style: AppText.smallSubHeader,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    SustainablePoints(sustainablePoints: 100),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  "Color:",
                                  style: AppText.strongStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    color: AppColor.black,
                                    shape: BoxShape.circle,
                                    boxShadow: [AppColor.defaultShadow],
                                  ),
                                ),
                                const SizedBox(
                                  width: 36,
                                ),
                                const Text(
                                  "Tamanho:",
                                  style: AppText.strongStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Text(
                                  "M",
                                  style: AppText.smallHeader,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Line(
                              color: AppColor.separatedLine,
                              width: maxWidth,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Origem",
                                  style: AppText.smallSubHeader,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Destino",
                                  style: AppText.smallSubHeader,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            Column(
                              children: List.generate(8, (index) {
                                return const PlaceToPlace(
                                  origin: "Origem",
                                  destination: "Destino",
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const Positioned(
                  //   bottom: 16,
                  //   child: Row(
                  //     children: [
                  //       Line(
                  //         width: 100,
                  //       ),
                  //       SizedBox(
                  //         width: 6,
                  //       ),
                  //       Line(
                  //         width: 100,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<PaletteGenerator> _updatePaletteGenerator() async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset("assets/sueter.png").image,
    );
    return paletteGenerator;
  }
}
