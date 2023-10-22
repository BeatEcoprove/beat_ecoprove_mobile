import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/headers.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';

class HeaderWithSearchBar extends StatelessWidget implements Headers {
  final StandardHeader standardHeader;

  const HeaderWithSearchBar({required this.standardHeader, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        standardHeader,
        const FormattedTextField(
          hintText: "Pesquisar",
          leftIcon: Icon(Icons.search_rounded),
        )
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(standardHeader.preferredSize.height + 58);
}
