import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/i_without_options_footer.dart';
import 'package:flutter/material.dart';

class WithoutOptionsFooter extends IWithoutOptionsFooter {
  const WithoutOptionsFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
    );
  }
}
