import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/profile/presentation/trade_points/trade_points_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TradePointsForm extends StatelessWidget {
  const TradePointsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<TradePointsViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
        title: 'Prémios',
        hasSustainablePoints: true,
        sustainablePoints: viewModel.user.sustainablePoints,
      ),
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 84),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tradeTable(viewModel),
                _tradeEcoCoinsToSustainablePoints(viewModel),
                _tradeSustainablePointsToEcoCoins(viewModel),
                FormattedButton(
                  content: "Confirmar",
                  textColor: Colors.white,
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
        type: AppBackgrounds.trade,
      ),
    );
  }

  Widget _tradeTable(TradePointsViewModel viewModel) {
    const Radius borderRadius = Radius.circular(10);

    return Column(
      children: [
        const Text(
          "Trocar Moedas",
          style: AppText.titleToScrollSection,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 50,
          width: 230,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColor.widgetBackground,
            borderRadius: BorderRadius.all(borderRadius),
            boxShadow: [AppColor.defaultShadow],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.getEcoCoins.toString(),
                style: AppText.titleToScrollSection,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 4,
              ),
              const SvgImage(
                width: 22,
                height: 22,
                path: "assets/points/eco_coins_points_icon.svg",
              ),
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.compare_arrows_rounded,
                color: AppColor.widgetSecondary,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                viewModel.getSustainablePoints.toString(),
                style: AppText.titleToScrollSection,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 4,
              ),
              const SvgImage(
                width: 24,
                height: 24,
                path: "assets/points/sustainable_points_icon.svg",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tradeEcoCoinsToSustainablePoints(TradePointsViewModel viewModel) {
    const Radius borderRadius = Radius.circular(10);

    return Column(
      children: [
        const Text(
          "Eco-Coins para Pontos Sustentáveis",
          style: AppText.titleToScrollSection,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 140,
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: AppColor.widgetBackground,
                borderRadius: BorderRadius.all(borderRadius),
                boxShadow: [AppColor.defaultShadow],
              ),
              child: DefaultFormattedTextField(
                hintText: '',
                inputFormatter: [
                  LengthLimitingTextInputFormatter(8),
                ],
                onChange: (ecoCoins) async =>
                    viewModel.setQuantityEcoCoins(ecoCoins),
                initialValue: viewModel
                    .getValue(FormFieldValues.ecoCoins)
                    .value
                    .toString(),
                errorMessage:
                    viewModel.getValue(FormFieldValues.ecoCoins).error,
              ),
            ),
            const Icon(
              Icons.arrow_right_alt_rounded,
              color: AppColor.widgetSecondary,
            ),
            Container(
              height: 50,
              width: 140,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColor.widgetBackground,
                borderRadius: BorderRadius.all(borderRadius),
                boxShadow: [AppColor.defaultShadow],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ((viewModel.getValue(FormFieldValues.ecoCoins).value ~/
                                viewModel.getEcoCoins) *
                            viewModel.getSustainablePoints)
                        .toString(),
                    style: AppText.titleToScrollSection,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SvgImage(
                    width: 24,
                    height: 24,
                    path: "assets/points/sustainable_points_icon.svg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tradeSustainablePointsToEcoCoins(TradePointsViewModel viewModel) {
    const Radius borderRadius = Radius.circular(10);

    return Column(
      children: [
        const Text(
          "Pontos Sustentáveis para Eco-Coins",
          style: AppText.titleToScrollSection,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 140,
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: AppColor.widgetBackground,
                borderRadius: BorderRadius.all(borderRadius),
                boxShadow: [AppColor.defaultShadow],
              ),
              child: DefaultFormattedTextField(
                hintText: '',
                inputFormatter: [
                  LengthLimitingTextInputFormatter(8),
                ],
                onChange: (sustainablePoints) async =>
                    viewModel.setQuantitySustainablePoints(sustainablePoints),
                initialValue: viewModel
                    .getValue(FormFieldValues.sustainablePoints)
                    .value
                    .toString(),
                errorMessage:
                    viewModel.getValue(FormFieldValues.sustainablePoints).error,
              ),
            ),
            const Icon(
              Icons.arrow_right_alt_rounded,
              color: AppColor.widgetSecondary,
            ),
            Container(
              height: 50,
              width: 140,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColor.widgetBackground,
                borderRadius: BorderRadius.all(borderRadius),
                boxShadow: [AppColor.defaultShadow],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ((viewModel
                                    .getValue(FormFieldValues.sustainablePoints)
                                    .value ~/
                                viewModel.getSustainablePoints) *
                            viewModel.getEcoCoins)
                        .toString(),
                    style: AppText.titleToScrollSection,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SvgImage(
                    width: 22,
                    height: 22,
                    path: "assets/points/eco_coins_points_icon.svg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
