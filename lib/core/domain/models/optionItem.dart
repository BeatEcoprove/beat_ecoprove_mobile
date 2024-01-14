import 'package:flutter/material.dart';

class OptionItem {
  final String name;
  final VoidCallback action;

  OptionItem({
    required this.name,
    required this.action,
  });
}
