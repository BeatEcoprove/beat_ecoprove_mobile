import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:flutter/material.dart';

class GroupForm extends StatelessWidget {
  const GroupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<GroupViewModel>(context);

    return Scaffold(
      appBar: StandardHeader(
        title: "Grupos",
        sustainablePoints: viewModel.user.sustainablePoints,
        hasSustainablePoints: false,
        hasSettings: false,
        hasSearchBar: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 26),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Grupos",
                  textAlign: TextAlign.center,
                  style: AppText.titleToScrollSection,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
