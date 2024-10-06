import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:flutter/material.dart';

class ListDetailsViewParams {
  final String title;
  final int numberMaxItemsPage;
  final Future<List<Widget>> Function(
    String searchTerm,
    ListDetailsViewModel viewModel,
  )? onSearch;
  final Future<List<Widget>> Function(
    String searchTerm,
    ListDetailsViewModel viewModel,
    int page,
    int pageSize,
  )? onSearchPagination;

  ListDetailsViewParams({
    this.onSearch,
    this.onSearchPagination,
    required this.title,
    required this.numberMaxItemsPage,
  });
}
