import 'package:beat_ecoprove/core/domain/models/service.dart';

class PayablePrizeItem extends ServiceItem {
  final int prize;

  PayablePrizeItem({
    required super.title,
    required super.idText,
    required super.content,
    required super.backgroundColor,
    required super.borderColor,
    required super.foregroundColor,
    required super.action,
    required this.prize,
  });
}
