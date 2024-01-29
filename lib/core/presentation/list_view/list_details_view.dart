import 'package:beat_ecoprove/core/presentation/list_view/list_details_form.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class ListDetailsViewParams {
  final String title;
  final Future<List<Widget>> Function(String searchTerm) onSearch;

  ListDetailsViewParams({required this.title, required this.onSearch});
}

class ListDetailsView extends StatelessWidget {
  final ListDetailsViewParams params;

  const ListDetailsView({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<ListDetailsViewModel>(),
      child: ListDetailsForm(params: params),
    );
  }
}
