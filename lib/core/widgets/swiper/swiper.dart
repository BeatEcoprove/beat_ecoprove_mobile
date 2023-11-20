import 'package:beat_ecoprove/core/widgets/footer/footer.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class Swiper extends StatefulWidget {
  final List<Widget> views;

  const Swiper({super.key, required this.views});

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  static const _animationDuration = Duration(milliseconds: 300);
  late int selectedIndex = 0;
  final PageController controller = PageController(initialPage: 0);

  Future _animateToPage(int page) {
    return controller.animateToPage(page,
        duration: _animationDuration, curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        currentIndex: selectedIndex,
        options: const [
          Icon(Icons.home_rounded),
          SvgImage(path: "assets/shirt.svg"),
          Icon(Icons.public_rounded),
          Icon(Icons.person),
        ],
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
