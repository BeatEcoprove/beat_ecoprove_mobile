import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item.dart';

abstract class CompactListItemHeader extends CompactListItem {
  final String title;

  const CompactListItemHeader({
    super.key,
    required this.title,
  });
}
