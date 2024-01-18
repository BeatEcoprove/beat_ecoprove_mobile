import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/wrap_services.dart';
import 'package:flutter/material.dart';

class InfoClothServiceForm extends StatelessWidget {
  final String title;

  const InfoClothServiceForm({
    super.key,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<InfoClothServiceViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    child: WrapServices(
                      title: title,
                      services: viewModel.getAllServices,
                      blockedServices: viewModel.blockedServices(),
                      onSelectionChanged: (service) =>
                          viewModel.changeServiceSelection(service),
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
}
