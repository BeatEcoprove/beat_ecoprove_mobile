import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:flutter/material.dart';

class ListDetailsViewParams {
  final String title;
  final Future<List<Widget>> Function(
    String searchTerm,
    ListDetailsViewModel viewModel,
  ) onSearch;

  ListDetailsViewParams({
    required this.title,
    required this.onSearch,
  });
}
