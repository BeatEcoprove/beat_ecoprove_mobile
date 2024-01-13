import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/profile/presentation/trade_points/trade_points_view_model.dart';
import 'package:flutter/material.dart';

class TradePointsForm extends StatelessWidget {
  const TradePointsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<TradePointsViewModel>(context);

    return Scaffold(
      appBar: StandardHeader(
        title: 'Prémios',
        hasSustainablePoints: true,
        sustainablePoints: viewModel.user.sustainablePoints,
      ),
      body: const AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 84,
                ),
                Row(),
              ],
            ),
          ),
        ),
        type: AppBackgrounds.settings,
      ),
    );
  }
}
