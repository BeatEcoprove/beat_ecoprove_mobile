import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/core/widgets/swiper/swiper.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton_service_provider/main_skeleton_service_provider_view_model.dart';
import 'package:flutter/material.dart';

class MainSkeletonServiceProviderView
    extends LinearView<MainSkeletonServiceProviderViewModel> {
  const MainSkeletonServiceProviderView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(
      BuildContext context, MainSkeletonServiceProviderViewModel viewModel) {
    return PopScope(
      canPop: false,
      child: Swiper(
        hasRegisterCloth: false,
        views: viewModel.getViews(),
        bottomNavigationBarOptions: const [
          Icon(Icons.home_rounded),
          SvgImage(path: "assets/shirt.svg"),
          Icon(Icons.store_mall_directory),
          Icon(Icons.public_rounded),
          Icon(Icons.person),
        ],
      ),
    );
  }
}
