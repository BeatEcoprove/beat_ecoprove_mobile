import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/header.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';

class HeaderWithSearchBar extends Header {
  final StandardHeader standardHeader;

  const HeaderWithSearchBar({required this.standardHeader, Key? key})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(standardHeader.preferredSize.height + 58);

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        standardHeader,
        const DefaultFormattedTextField(
          hintText: "Pesquisar",
          leftIcon: Icon(Icons.search_rounded),
        )
      ],
    );
  }
}
