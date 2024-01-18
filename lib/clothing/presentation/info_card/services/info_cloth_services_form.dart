import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/wrap_services.dart';
import 'package:flutter/material.dart';

class InfoClothServiceForm extends StatelessWidget {
  final CardItem card;
  final String title;

  const InfoClothServiceForm({
    super.key,
    this.title = '',
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<InfoClothServiceViewModel>(context);
    viewModel.clothId = card.id;

    return Scaffold(
      body: AppBackground(
        content: GoBack(
          posLeft: 18,
          posTop: 18,
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
                        future: viewModel.fetchServices(card.id),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const CircularProgressIndicator(
                                color: AppColor.primaryColor,
                                strokeWidth: 4,
                              );
                            default:
                              return WrapServices(
                                title: title,
                                services: viewModel.getAllServices,
                                blockedServices: viewModel.blockedServices(),
                                onSelectionChanged: (service) =>
                                    viewModel.changeServiceSelection(service),
                              );
                          }
                        }),
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
}
