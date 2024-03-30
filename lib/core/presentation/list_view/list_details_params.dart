import 'package:flutter/material.dart';

class ListDetailsViewParams {
  final String title;
  final Future<List<Widget>> Function(String searchTerm) onSearch;

  ListDetailsViewParams({required this.title, required this.onSearch});
}
