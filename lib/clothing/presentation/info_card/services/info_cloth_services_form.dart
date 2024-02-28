import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget_with_button.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/core/widgets/wrap_services.dart';
import 'package:flutter/material.dart';

class InfoClothServiceForm extends StatefulWidget {
  final CardItem card;
  final String title;
  final IBucketInfoManager bucketInfoManager;

  const InfoClothServiceForm({
    super.key,
    this.title = '',
    required this.card,
    required this.bucketInfoManager,
  });
  @override
  State<InfoClothServiceForm> createState() => _InfoClothServiceFormState();
}

class _InfoClothServiceFormState extends State<InfoClothServiceForm> {
  late InfoClothServiceViewModel viewModel;
  late Modal _overlay;

  @override
  void initState() {
    super.initState();

    _overlay = Modal(
      top: 72,
      bottom: 72,
      left: 36,
      right: 36,
      action: () async {
        if (!viewModel.isLoading) {
          await viewModel.registerBucket(widget.card.id);
        }
      },
      titleModal: "Criar Cesto",
      buttonText: "Criar",
    );
  }

  Widget createBucketCard() {
    return DefaultFormattedTextField(
      hintText: "Nome do cesto",
      onChange: (name) => viewModel.setName(name),
      initialValue: viewModel.getValue(FormFieldValues.name).value,
      errorMessage: viewModel.getValue(FormFieldValues.name).error,
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ViewModel.of<InfoClothServiceViewModel>(context);
    if (widget.card.hasChildren) {
      viewModel.clothId = (widget.card.child as List<CardItem>)
          .map((element) => element.id)
          .where((e) => !widget.bucketInfoManager.getAllClothes().contains(e))
          .toList();
    } else {
      viewModel.clothId = [widget.card.id];
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          onExit: () => widget.bucketInfoManager.removeClothes(),
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
                    child: FutureBuilder(
                      future: viewModel.fetchServices(
                          widget.card.id, widget.card.hasChildren, context),
                      builder: (context, snapshot) => WrapServices(
                        title: widget.title,
                        services: formatServices(
                          widget.card.id,
                          widget.card.hasChildren,
                          context,
                        ),
                        blockedServices: viewModel.blockedServices(),
                        onSelectionChanged: (service) =>
                            viewModel.changeServiceSelection(service),
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

  List<ServiceTemplate> formatServices(
      String clothId, bool isBucket, BuildContext context) {
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
                action: () => _overlay.create(context, createBucketCard()),
              ),
              for (var bucket in viewModel.getBuckets.entries) ...{
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
                  action: () async =>
                      await viewModel.addToBucket(bucket.key, clothId),
                )
              }
            ]
          },
        ),
      ],
      ...viewModel.getAllServices,
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
}
