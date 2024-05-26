import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/formatters/price_formatter.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/avatar_chooser/retangular_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_params.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePrizeView
    extends ArgumentView<CreatePrizeViewModel, CreatePrizeParams> {
  const CreatePrizeView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  Column _voucherParams() {
    return Column(
      children: [
        DefaultFormattedTextField(
          hintText: "Custo do Voucher",
          keyboardType: TextInputType.number,
          inputFormatter: [
            LengthLimitingTextInputFormatter(12),
            PriceFormatter(),
          ],
          onChange: (priceItem) async => viewModel.setPriceItem(priceItem),
          initialValue: viewModel.getValue(FormFieldValues.priceItem).value,
          errorMessage: viewModel.getValue(FormFieldValues.priceItem).error,
        ),
        const SizedBox(
          height: 12,
        ),
        DefaultFormattedTextField(
          hintText: "Quantidade de Vouchers",
          keyboardType: TextInputType.number,
          inputFormatter: [
            LengthLimitingTextInputFormatter(9),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChange: (priceItem) async => viewModel.setQuantityItem(priceItem),
          initialValue: viewModel.getValue(FormFieldValues.quantityItem).value,
          errorMessage: viewModel.getValue(FormFieldValues.quantityItem).error,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, CreatePrizeViewModel viewModel) {
    double horizontalPadding = 16;
    double maxWidth =
        MediaQuery.of(context).size.width - (2 * horizontalPadding);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
          content: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GoBack(
              posLeft: 22,
              posTop: 48,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 26),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 86,
                            ),
                            DefaultFormattedTextField(
                              hintText: "Título",
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(25),
                              ],
                              onChange: (title) async =>
                                  viewModel.setTitle(title),
                              initialValue: viewModel
                                  .getValue(FormFieldValues.title)
                                  .value,
                              errorMessage: viewModel
                                  .getValue(FormFieldValues.title)
                                  .error,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            DefaultFormattedTextField(
                              hintText: "Descrição (optional)",
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              onChange: (description) async =>
                                  viewModel.setDescription(description),
                              initialValue: viewModel
                                  .getValue(FormFieldValues.description)
                                  .value,
                              errorMessage: viewModel
                                  .getValue(FormFieldValues.description)
                                  .error,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Column(
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Intervalo",
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: AppText.title5,
                                        color: AppColor.widgetSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    DatePicker(
                                      width: 150,
                                      height: 45,
                                      nowToBefore: false,
                                      value: viewModel
                                          .getValue(FormFieldValues.beginAt)
                                          .value,
                                      onDateChanged: (date) =>
                                          viewModel.setBeginDate(date),
                                    ),
                                    const Text(
                                      " - ",
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: AppText.title5,
                                        color: AppColor.widgetSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    DatePicker(
                                      width: 150,
                                      height: 45,
                                      nowToBefore: false,
                                      value: viewModel
                                          .getValue(FormFieldValues.endAt)
                                          .value,
                                      onDateChanged: (date) =>
                                          viewModel.setEndDate(date),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                if (args.type == "voucher") _voucherParams(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          "Imagem",
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: AppText.title5,
                                            color: AppColor.widgetSecondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RetangularAvatarChooser(
                                          height: 140,
                                          width: maxWidth,
                                          color: AppColor.widgetSecondary,
                                          imageProvider: viewModel.getPicture(),
                                          onPress: () =>
                                              viewModel.getImageFromGallery(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 154,
                            height: 75,
                            decoration: const BoxDecoration(
                                color: AppColor.widgetBackground,
                                boxShadow: [AppColor.defaultShadow],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Custo",
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: AppText.title5,
                                    color: AppColor.widgetSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Points.sustainablePoints(
                                  width: 126,
                                  height: 36,
                                  points:
                                      //TODO: MAKE THIS POSSIBLE (MULTIPLY THE VALUE WITH THE QUANTITY)
                                      // viewModel.quantityItem != 0
                                      //     ? args.price * quantityItem
                                      //     :
                                      args.price,
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        FormattedButton(
                          content: "Criar",
                          textColor: Colors.white,
                          disabled: viewModel.thereAreErrors,
                          onPress: () async => viewModel.registerAdvert(),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          type: AppBackgrounds.settings),
    );
  }
}
