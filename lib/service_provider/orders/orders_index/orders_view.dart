import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_form.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view_model.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<OrdersViewModel>(),
      child: const OrdersForm(),
    );
  }
}
