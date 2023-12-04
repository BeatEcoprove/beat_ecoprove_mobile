import 'package:beat_ecoprove/clothing/presentation/info_cloth/services/info_cloth_services_view_model.dart';
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
      body: AppBackground(
        content: WrapServices(
          title: title,
          services: viewModel.getAllServices,
          blockedServices: viewModel.blockedServices(),
          onSelectionChanged: (service) =>
              viewModel.changeServiceSelection(service),
        ),
        type: AppBackgrounds.closet,
      ),
    );
  }
}
