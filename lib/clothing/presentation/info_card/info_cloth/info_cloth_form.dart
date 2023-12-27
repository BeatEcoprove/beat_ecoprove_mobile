import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_cloth/info_cloth_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/place_to_place.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/rounded_button.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/sustainable_points.dart';
import 'package:flutter/material.dart';

class InfoClothForm extends StatefulWidget {
  final String index;
  final CardItem card;

  const InfoClothForm({
    super.key,
    required this.card,
    required this.index,
  });

  @override
  State<InfoClothForm> createState() => _InfoClothFormState();
}

class _InfoClothFormState extends State<InfoClothForm> {
  late bool isInUse = widget.card.clothState == ClothStates.inUse;

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<InfoClothViewModel>(context);

    const Radius borderRadius = Radius.circular(25);
    double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GoBack(
        posTop: 18,
        posLeft: 18,
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                child: SizedBox(
                  width: double.maxFinite,
                  height: 257,
                  child: Center(
                    widthFactor: 257,
                    child: PresentImage(path: ServerImage(widget.card.child)),
                  ),
                ),
              ),
              if (widget.card.hasProfile != null)
                Positioned(
                  left: 24,
                  top: 180,
                  child: IconButtonRectangular(
                    dimension: 50,
                    object: PresentImage(
                      path: widget.card.hasProfile!,
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
                    text: "Utilizar",
                    textWhenSelected: "Cancelar",
                    isSelect: isInUse,
                    onAction: () async {
                      await viewModel.setClothState([widget.card.id], isInUse);
                      setState(() {
                        isInUse = !isInUse;
                      });
                    }),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.card.title,
                                  style: AppText.smallHeader,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.card.brand!,
                                  style: AppText.subHeader,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Eco-Score",
                                  style: AppText.smallSubHeader,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SustainablePoints(
                                    sustainablePoints: widget.card.ecoScore!),
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
                              decoration: BoxDecoration(
                                color: widget.card.color,
                                shape: BoxShape.circle,
                                boxShadow: const [AppColor.defaultShadow],
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
                            Text(
                              widget.card.size!,
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
                          children: List.generate(2, (index) {
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
      ),
    );
  }
}
