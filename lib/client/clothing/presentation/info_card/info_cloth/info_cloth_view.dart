import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_parms.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_view_model.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/rounded_button.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class InfoClothView extends ArgumentView<InfoClothViewModel, InfoClothParams> {
  final Radius borderRadius = const Radius.circular(25);

  const InfoClothView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, InfoClothViewModel viewModel) {
    double maxWidth = MediaQuery.of(context).size.width;
    viewModel.isInUse = args.card.clothState == ClothStates.inUse;
    viewModel.disableButton = args.card.clothState == ClothStates.blocked;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    child: PresentImage(
                        path: ServerImage(
                      args.card.child,
                    )),
                  ),
                ),
              ),
              if (args.card.hasProfile != null)
                Positioned(
                  left: 24,
                  top: 180,
                  child: IconButtonRectangular(
                    dimension: 50,
                    object: PresentImage(
                      path: args.card.hasProfile!,
                    ),
                  ),
                ),
              Positioned(
                top: 18,
                right: 28,
                child: WithOptionsFooter(
                  options: [
                    OptionItem(
                      name: "Histórico de Ações",
                      action: () => viewModel.getClothHistory(),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 28,
                top: 185,
                child: RoundedButton(
                  disabled: viewModel.disableButton,
                  text: viewModel.disableButton ? "Bloqueado" : "Utilizar",
                  textWhenSelected: "Cancelar",
                  isSelect: viewModel.isInUse,
                  onAction: () async =>
                      await viewModel.setClothState(args.card.id, args.card),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: borderRadius,
                      topRight: borderRadius,
                    ),
                    color: AppColor.widgetBackground,
                    boxShadow: const [AppColor.defaultShadow],
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
                                  args.card.title,
                                  style: AppText.smallHeader,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  args.card.brand!,
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
                                Points.ecoScore(points: args.card.ecoScore!),
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
                                color: args.card.color,
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
                              args.card.size!,
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
                        //TODO: GET BY BEAT API
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Origem",
                        //       style: AppText.smallSubHeader,
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //     Text(
                        //       "Destino",
                        //       style: AppText.smallSubHeader,
                        //       overflow: TextOverflow.ellipsis,
                        //     )
                        //   ],
                        // ),
                        // Column(
                        //   children: List.generate(
                        //     2,
                        //     (index) {
                        //       return const PlaceToPlace(
                        //         origin: "Origem",
                        //         destination: "Destino",
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
