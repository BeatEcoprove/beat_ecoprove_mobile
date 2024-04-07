import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_view_model.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_params.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget_with_button.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/core/widgets/wrap_services.dart';
import 'package:flutter/material.dart';

class InfoClothServiceViewAlt extends ArgumentedView<
    InfoClothServiceViewModelAlt, InfoClothServiceParms> {
  const InfoClothServiceViewAlt({
    super.key,
    required super.viewModel,
    required super.args,
  });

  get title => "";

  Widget createBucketCard() {
    return DefaultFormattedTextField(
      hintText: "Nome do cesto",
      onChange: (name) => viewModel.setName(name),
      initialValue: viewModel.getValue(FormFieldValues.name).value,
      errorMessage: viewModel.getValue(FormFieldValues.name).error,
    );
  }

  void createOverlay(
    BuildContext context,
    InfoClothServiceViewModelAlt viewModel,
  ) {
    Modal(
      top: 72,
      bottom: 72,
      left: 36,
      right: 36,
      action: () async {
        await viewModel.registerBucket(args.card.id);
      },
      titleModal: "Criar Cesto",
      buttonText: "Criar",
    ).create(
      context,
      createBucketCard(),
    );
  }

  List<ServiceTemplate> formatServices(
    String clothId,
    bool isBucket,
    BuildContext context,
    List<ServiceTemplate> services,
  ) {
    return [
      if (!isBucket) ...[
        Service(
          foregroundColor: AppColor.buttonBackground,
          borderColor: AppColor.widgetBackground,
          backgroundColor: AppColor.widgetBackground,
          title: "Cesto",
          idText: "bucket",
          content: const SvgImage(
            path: "assets/services/bucket.svg",
            height: 20,
            width: 20,
            color: AppColor.buttonBackground,
          ),
          services: {
            "Em que cesto pretende adicionar esta peça?": [
              ServiceItem(
                foregroundColor: AppColor.buttonBackground,
                borderColor: AppColor.widgetBackground,
                backgroundColor: AppColor.widgetBackground,
                title: "Novo cesto",
                idText: "bucket_new_bucket",
                content: const Icon(
                  Icons.add,
                  size: 50,
                  color: AppColor.buttonBackground,
                ),
                action: () => createOverlay(context, viewModel),
              ),
              ...displayBuckets(clothId)
            ]
          },
        ),
      ],
      if (services.isNotEmpty) ...services,
      ServiceItem(
        foregroundColor: AppColor.buttonBackground,
        borderColor: AppColor.widgetBackground,
        title: "Enviar para reciclagem",
        idText: "recycle",
        backgroundColor: AppColor.widgetBackground,
        content: const SvgImage(
          path: "assets/services/recycle.svg",
          height: 30,
          width: 30,
          color: AppColor.buttonBackground,
        ),
        action: () {},
      ),
      ServiceItem(
        foregroundColor: AppColor.buttonBackground,
        borderColor: AppColor.widgetBackground,
        title: "Colocar no lixo",
        idText: "trash",
        backgroundColor: AppColor.widgetBackground,
        content: const SvgImage(
          path: "assets/services/trash.svg",
          height: 30,
          width: 30,
          color: AppColor.buttonBackground,
        ),
        action: () {},
      )
    ];
  }

  @override
  Widget build(BuildContext context, InfoClothServiceViewModelAlt viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          onExit: () => viewModel.bucketInfoManager.removeClothes(),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 64,
                      bottom: 16,
                      right: 16,
                      left: 16,
                    ),
                    child: viewModel.isLoading
                        ? WrapServices(
                            title: title,
                            services: formatServices(
                              args.card.id,
                              args.card.hasChildren,
                              context,
                              viewModel.services,
                            ),
                            blockedServices: viewModel.blockedServices,
                            onSelectionChanged: (service) {
                              viewModel.changeServiceSelection(service);
                            },
                          )
                        : const Expanded(
                            child: CircularProgressIndicator(
                              color: AppColor.darkGreen,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        type: AppBackgrounds.closet,
      ),
    );
  }

  List<ServiceItem> displayBuckets(String clothId) {
    List<ServiceItem> items = [];

    for (var bucket in viewModel.buckets.entries) {
      items.add(
        ServiceItem(
          backgroundColor: AppColor.widgetBackground,
          borderColor: Colors.transparent,
          foregroundColor: AppColor.buttonBackground,
          title: bucket.value,
          idText: "bucket",
          content: const SvgImage(
            path: "assets/services/bucket.svg",
            height: 20,
            width: 20,
            color: AppColor.buttonBackground,
          ),
          action: () async => await viewModel.addToBucket(bucket.key, clothId),
        ),
      );
    }

    return items;
  }
}
