import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_form.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_view_model.dart';
import 'package:flutter/material.dart';

class StoreWorkersView extends StatelessWidget {
  final StoreParams storeParams;

  const StoreWorkersView({Key? key, required this.storeParams})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<StoreWorkersViewModel>(),
        child: StoreWorkersForm(params: storeParams));
  }
}
