import 'package:beat_ecoprove/core/widgets/footer/footer.dart';
import 'package:flutter/material.dart';

class Swiper extends StatefulWidget {
  final List<Widget> views;
  final List<Widget> bottomNavigationBarOptions;
  final bool hasRegisterCloth;
  final int? index;

  const Swiper({
    super.key,
    required this.bottomNavigationBarOptions,
    this.hasRegisterCloth = true,
    required this.views,
    this.index,
  });

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  static const _animationDuration = Duration(milliseconds: 750);
  late int selectedIndex = widget.index ?? 0;
  late final PageController controller;

  @override
  void initState() {
    super.initState();

    controller = PageController(
      initialPage: widget.index ?? selectedIndex,
      keepPage: false,
    );
  }

  Future _animateToPage(int page) {
    return controller.animateToPage(page,
        duration: _animationDuration, curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        controller: controller,
        itemCount: widget.views.length,
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        itemBuilder: (context, index) {
          selectedIndex = index;

          return widget.views[selectedIndex];
        },
      ),
      bottomNavigationBar: Footer(
        hasRegisterCloth: widget.hasRegisterCloth,
        currentIndex: selectedIndex,
        options: widget.bottomNavigationBarOptions,
        onChangeSelection: (navigationSelection) {
          setState(() {
            selectedIndex = navigationSelection;
            _animateToPage(selectedIndex);
          });
        },
      ),
    );
  }
}
