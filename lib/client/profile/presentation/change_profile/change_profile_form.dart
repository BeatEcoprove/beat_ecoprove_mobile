import 'package:async/async.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/presentation/make%20_profile_action_view.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeProfileForm extends StatelessWidget {
  const ChangeProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ChangeProfileViewModel>(context);
    final goRouter = GoRouter.of(context);
    final memo = AsyncMemoizer();

    return Scaffold(
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: FutureBuilder(
            future:
                memo.runOnce(() async => await viewModel.getNestedProfiles()),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 36),
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
                            Column(children: [
                              _buildProfileItem(
                                  viewModel.profilesResult.mainProfile,
                                  goRouter,
                                  viewModel,
                                  isMain: true),
                              ...viewModel.profilesResult.nestedProfiles
                                  .map((profile) => _buildProfileItem(
                                      profile, goRouter, viewModel))
                                  .toList(),
                            ]),
                            const SizedBox(
                              height: 36,
                            ),
                            Column(
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: [
                                    const Text(
                                      "Eco-Score dos perfis",
                                      style: AppText.strongStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Points.ecoScore(
                                      points: [
                                        viewModel.profilesResult.mainProfile,
                                        ...viewModel
                                            .profilesResult.nestedProfiles
                                      ].fold(
                                          0,
                                          (previousValue, myObject) =>
                                              previousValue +
                                              myObject.ecoScorePoints),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              runSpacing: 6,
                              spacing: 6,
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
                                  onTap: () async =>
                                      await viewModel.createProfile(),
                                  child: const Text(
                                    "Adicionar",
                                    style: AppText.underlineStyle,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              }
            },
          ),
        ),
        type: AppBackgrounds.login,
      ),
    );
  }

  Widget _buildProfileItem(ProfileResult profile, GoRouter goRouter,
      ChangeProfileViewModel viewModel,
      {bool isMain = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: CompactListItem.userCanClick(
        click: () => viewModel.selectProfile(profile.id),
        hasBorder: viewModel.selectedProfile(profile.id, isMain),
        title: profile.username,
        userLevel: profile.level,
        sustainablePoints: profile.sustainabilityPoints,
        ecoScorePoints: profile.ecoScorePoints,
        typeEnd: (viewModel.nestedProfile != profile.id) && !isMain
            ? "default"
            : "withoutOptions",
        options: [
          OptionItem(
            name: 'Promover',
            action: () {
              goRouter.push(
                "/make_profile_action",
                extra: MakeProfileActionViewParams(
                  text:
                      "Tem a certeza que pretende criar uma conta com este perfil?",
                  textButton: "Criar",
                  profile: profile,
                  action: () async =>
                      await viewModel.promoteProfile(profile.id),
                ),
              );
            },
          ),
          OptionItem(
            name: 'Remover',
            action: () {
              goRouter.push(
                "/make_profile_action",
                extra: MakeProfileActionViewParams(
                  text: "Tem a certeza que pretende remover este perfil?",
                  textButton: "Remover",
                  profile: profile,
                  action: () async => await viewModel.deleteProfile(profile.id),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
