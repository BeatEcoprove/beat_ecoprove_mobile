import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_form.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view_model.dart';
import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<StoreViewModel>(),
        child: const StoreForm());
  }
}
