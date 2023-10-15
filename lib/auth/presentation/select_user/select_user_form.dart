import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/selector_button/selector_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    final goRouter = GoRouter.of(context);

    return ScrollHandler(
      topPadding: _topPadding,
      bottomPadding: _bottomPadding,
      leftPadding: _horizontalPadding,
      rightPadding: _horizontalPadding,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          onIndexChanged: (selectedIndex) => print(selectedIndex.toString()),
        ),

        FormattedButton(
          content: "Continuar",
          onPress: () {
            goRouter.go("/sign_in");
          },
        ),
        // Footer
      ]),
    );
  }
}
