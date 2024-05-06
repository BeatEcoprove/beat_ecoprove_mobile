import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/core/widgets/swiper/swiper.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton/main_skeleton_view_model.dart';
import 'package:flutter/material.dart';

class MainSkeletonView extends LinearView<MainSkeletonViewModel> {
  const MainSkeletonView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, MainSkeletonViewModel viewModel) {
    return Swiper(
      views: viewModel.getViews(),
      bottomNavigationBarOptions: const [
        Icon(Icons.home_rounded),
        SvgImage(path: "assets/shirt.svg"),
        Icon(Icons.public_rounded),
        Icon(Icons.person),
      ],
    );
  }
}
