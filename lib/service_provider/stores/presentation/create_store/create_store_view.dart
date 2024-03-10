import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_form.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view_model.dart';
import 'package:flutter/material.dart';

class CreateStoreView extends StatelessWidget {
  const CreateStoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<CreateStoreViewModel>(),
        child: const CreateStoreForm());
  }
}
