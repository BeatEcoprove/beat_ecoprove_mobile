import 'package:beat_ecoprove/core/presentation/list_widget_view/list_widget_view_model.dart';
import 'package:flutter/material.dart';

class ListWidgetViewParams {
  final String title;
  final String noResultsText;
  final Future<List<Widget>> Function(
    ListWidgetViewModel viewModel,
  ) getContent;

  ListWidgetViewParams({
    required this.title,
    required this.noResultsText,
    required this.getContent,
  });
}
