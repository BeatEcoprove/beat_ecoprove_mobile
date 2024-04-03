import 'package:beat_ecoprove/client/register_cloth/routes.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(5);

  const FooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = DependencyInjection.locator<INavigationManager>();

    return InkWell(
      onTap: () async => await navigator.pushAsync(
        RegisterClothRoutes.registerCloth,
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColor.darkGreen,
            boxShadow: [AppColor.defaultShadow],
            borderRadius: BorderRadius.all(borderRadius)),
        height: 42,
        width: 50,
        child: const Icon(
          size: 24,
          Icons.add,
          color: AppColor.widgetBackground,
        ),
      ),
    );
  }
}
