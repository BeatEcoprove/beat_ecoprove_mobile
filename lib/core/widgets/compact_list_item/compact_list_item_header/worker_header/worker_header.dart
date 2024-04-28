import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/compact_list_item_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';

abstract class WorkerHeader extends CompactListItemHeader {
  final String subTitle;

  final HeightCard height;

  const WorkerHeader({
    super.key,
    required super.title,
    required this.subTitle,
    this.height = HeightCard.height88,
  });
}
