import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/selector_button/selector_button.dart';
import 'package:flutter/material.dart';

class SelectUserForm extends StatefulWidget {
  const SelectUserForm({super.key});

  @override
  State<SelectUserForm> createState() => _SelectUserFormState();
}

class _SelectUserFormState extends State<SelectUserForm> {
  static const double _topPadding = 200;
  static const double _bottomPadding = 100;
  static const double _horizontalPadding = 24;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          top: _topPadding,
          bottom: _bottomPadding),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: _calculateScreenHeight(context)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Selecione o Tipo de Utilizador",
                  textAlign: TextAlign.center,
                  style: AppText.header,
                ),
              ),

              SelectorButton(
                selectors: const ["Pessoal", "Empresa"],
                onIndexChanged: (selectedIndex) =>
                    print(selectedIndex.toString()),
              ),

              const FormattedButton(
                content: "Continuar",
              ),
              // Footer
            ]),
      ),
    ));
  }

  double _calculateScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - (_topPadding + _bottomPadding);
  }
}
