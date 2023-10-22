import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/footer/footer_button_add.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        boxShadow: [AppColor.defaultShadow],
      ),
      child: NavigationBar(
        backgroundColor: AppColor.widgetBackground,
        elevation: 10,
        selectedIndex: _currentIndex,
        onDestinationSelected: (newIndex) {
          _OnChange(newIndex);
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home_rounded,
              color: AppColor.bottomNavigationBarSelected,
            ),
            label: '',
            icon: Icon(
              Icons.home_rounded,
              color: AppColor.bottomNavigationBar,
            ),
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: AppColor.bottomNavigationBarSelected,
            ),
            label: '',
            icon: Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: AppColor.bottomNavigationBar,
            ),
          ),
          NavigationDestination(
            selectedIcon: FooterButton(),
            label: '',
            icon: FooterButton(),
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.public_rounded,
              color: AppColor.bottomNavigationBarSelected,
            ),
            label: '',
            icon: Icon(
              Icons.public_rounded,
              color: AppColor.bottomNavigationBar,
            ),
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: AppColor.bottomNavigationBarSelected,
            ),
            label: '',
            icon: Icon(
              Icons.person,
              color: AppColor.bottomNavigationBar,
            ),
          ),
        ],
        indicatorColor: Colors.transparent,
      ),
    );
  }

  void _OnChange(int newIndex) {
    switch (newIndex) {
      case 0:
        context.go('location');
        break;
      case 1:
        context.go('location');
        break;
      case 2:
        context.go('location');
        break;
      case 3:
        context.go('location');
        break;
      case 4:
        context.go('location');
        break;
      default:
    }
  }
}
