import 'package:flutter/material.dart';

class Service extends ServiceTemplate {
  final Map<String, List<ServiceItem>> services;

  Service({
    required super.title,
    required super.idText,
    required super.content,
    required this.services,
  });
}

class ServiceItem extends ServiceTemplate {
  final VoidCallback action;

  ServiceItem({
    required super.title,
    required super.idText,
    required super.content,
    required this.action,
  });
}

class ServiceTemplate {
  final String title;
  final String idText;
  final Widget content;

  ServiceTemplate({
    required this.title,
    required this.idText,
    required this.content,
  });
}
