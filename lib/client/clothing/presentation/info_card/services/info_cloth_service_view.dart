import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_view_model.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_params.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget_with_button.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/core/widgets/wrap_services.dart';
import 'package:flutter/material.dart';

class InfoClothServiceViewAlt
    extends ArgumentView<InfoClothServiceViewModelAlt, InfoClothServiceParams> {
  const InfoClothServiceViewAlt({
    super.key,
    required super.viewModel,
    required super.args,
  });

  get title => "";

  Widget createBucketCard() {
    return DefaultFormattedTextField(
      hintText:
          LocaleContext.get().client_clothing_info_card_services_bucket_name,
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
        await viewModel.registerBucket(args.index);
      },
      titleModal:
          LocaleContext.get().client_clothing_info_card_services_create_bucket,
      buttonText: LocaleContext.get().client_clothing_info_card_services_create,
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
          title: LocaleContext.get().client_clothing_info_card_services_bucket,
          idText: "bucket",
          content: const SvgImage(
            path: "assets/services/bucket.svg",
            height: 20,
            width: 20,
            color: AppColor.buttonBackground,
          ),
          services: {
            LocaleContext.get().client_clothing_info_card_services_add_garment:
                [
              ServiceItem(
                foregroundColor: AppColor.buttonBackground,
                borderColor: AppColor.widgetBackground,
                backgroundColor: AppColor.widgetBackground,
                title: LocaleContext.get()
                    .client_clothing_info_card_services_new_bucket,
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
        title: LocaleContext.get().client_clothing_info_card_services_recycle,
        idText: "recycle",
        backgroundColor: AppColor.widgetBackground,
        content: const SvgImage(
          path: "assets/services/recycle.svg",
          height: 30,
          width: 30,
          color: AppColor.buttonBackground,
        ),
        //TODO: IMPLEMENT WITH SERVICE PROVIDER
        action: () async => await viewModel.remove(clothId, isBucket),
      ),
      ServiceItem(
        foregroundColor: AppColor.buttonBackground,
        borderColor: AppColor.widgetBackground,
        title: LocaleContext.get().client_clothing_info_card_services_trash,
        idText: "trash",
        backgroundColor: AppColor.widgetBackground,
        content: const SvgImage(
          path: "assets/services/trash.svg",
          height: 30,
          width: 30,
          color: AppColor.buttonBackground,
        ),
        action: () async => await viewModel.remove(clothId, isBucket),
      )
    ];
  }

  Widget _buildContent(
      BuildContext context, InfoClothServiceViewModelAlt viewModel) {
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
                    child: WrapServices(
                      title: title,
                      noResultsText: LocaleContext.get()
                          .client_clothing_info_card_services_no_services,
                      services: formatServices(
                        args.index,
                        viewModel.cardItem.hasChildren,
                        context,
                        viewModel.services,
                      ),
                      blockedServices: viewModel.blockedServices,
                      onSelectionChanged: (service) {
                        viewModel.changeServiceSelection(service);
                      },
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

  @override
  Widget build(BuildContext context, InfoClothServiceViewModelAlt viewModel) {
    if (viewModel.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColor.darkGreen,
          ),
        ),
      );
    }

    return _buildContent(context, viewModel);
  }
}
