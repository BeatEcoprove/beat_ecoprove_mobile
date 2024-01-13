import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/profile/presentation/trade_points/trade_points_view_form.dart';
import 'package:beat_ecoprove/profile/presentation/trade_points/trade_points_view_model.dart';
import 'package:flutter/material.dart';

class TradePointsView extends StatelessWidget {
  const TradePointsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<TradePointsViewModel>(),
        child: const TradePointsForm());
  }
}
