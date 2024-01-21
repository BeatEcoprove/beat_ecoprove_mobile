import 'package:flutter/material.dart';

class Service<U> extends ServiceTemplate {
  final Map<String, List<ServiceTemplate>> services;

  Service({
    required super.title,
    required super.idText,
    required super.content,
    required super.backgroundColor,
    required super.borderColor,
    required super.foregroundColor,
    required this.services,
  });
}

class ServiceItem extends ServiceTemplate {
  final VoidCallback action;

  ServiceItem({
    required super.title,
    required super.idText,
    required super.content,
    required super.backgroundColor,
    required super.borderColor,
    required super.foregroundColor,
    required this.action,
  });
}

class ServiceTemplate {
  final String title;
  final String idText;
  final Color backgroundColor;
  final Color borderColor;
  final Color foregroundColor;
  final Widget content;

  ServiceTemplate({
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.foregroundColor,
    required this.idText,
    required this.content,
  });
}
