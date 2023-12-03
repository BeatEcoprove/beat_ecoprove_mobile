import 'package:flutter/material.dart';

class Service extends ServiceItem {
  final Map<String, List<ServiceItem>> services;

  Service({
    required super.title,
    required super.idText,
    required super.content,
    required this.services,
  });
}

class ServiceItem {
  final String title;
  final String idText;
  final Widget content;

  ServiceItem({
    required this.title,
    required this.idText,
    required this.content,
  });
}
