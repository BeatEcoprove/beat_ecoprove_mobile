import 'package:beat_ecoprove/core/domain/models/buttonItem.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/compact_list_item_footer.dart';

abstract class IWithButtonsFooter extends CompactListItemFooter {
  final List<ButtonItem> options;

  const IWithButtonsFooter({
    super.key,
    required this.options,
  });
}
