import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item_user.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/profile/presentation/change_profile/change_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeProfileForm extends StatelessWidget {
  const ChangeProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ChangeProfileViewModel>(context);
    final goRouter = GoRouter.of(context);

    return Scaffold(
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    const SvgImage(
                      path: "assets/applicationTitle.svg",
                      height: 74.23,
                      width: 224,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Column(
                      children: [
                        CompactListItemUser(
                          title: "David",
                          userLevel: 1,
                          sustainablePoints: 100,
                          ecoScorePoints: 600,
                          hasOptions: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Center(
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //TODO: CHANGE TO TOTAL OF POINTS OF THE PROFILES
                              Row(
                                children: [
                                  Text(
                                    "Eco-Score dos perfis",
                                    style: AppText.strongStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Points.ecoScore(points: 100),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Adicionar um perfil",
                                style: AppText.strongStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.go("/");
                                },
                                child: const Text(
                                  "Adicionar",
                                  style: AppText.underlineStyle,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        type: AppBackgrounds.login,
      ),
    );
  }
}
