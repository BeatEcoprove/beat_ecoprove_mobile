import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/profile_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_view_model.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class ChangeProfileView extends LinearView<ChangeProfileViewModel> {
  const ChangeProfileView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, ChangeProfileViewModel viewModel) {
    return Scaffold(
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: FutureBuilder(
            future: viewModel.getNestedProfiles(),
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
                                  viewModel,
                                  isMain: true),
                              ...viewModel.profilesResult.nestedProfiles
                                  .map((profile) =>
                                      _buildProfileItem(profile, viewModel))
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

  Widget _buildProfileItem(
    ProfileResult profile,
    ChangeProfileViewModel viewModel, {
    bool isMain = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: CompactListItemRoot(
        height: HeightCard.height88,
        padding: PaddingCard.padding0,
        click: () async => viewModel.selectProfile(profile.id),
        items: [
          ProfileHeader(
            hasBorder: viewModel.selectedProfile(profile.id, isMain),
            title: profile.username,
            userLevel: profile.level,
            sustainablePoints: profile.sustainabilityPoints,
            ecoScorePoints: profile.ecoScorePoints,
          ),
          (viewModel.nestedProfile != profile.id) && !isMain
              ? WithOptionsFooter(
                  options: [
                    OptionItem(
                      name: 'Promover',
                      action: () => viewModel.goToPromoteProfile(profile),
                    ),
                    OptionItem(
                      name: 'Remover',
                      action: () => viewModel.goToDeleteProfile(profile),
                    ),
                  ],
                )
              : const WithoutOptionsFooter()
        ],
      ),
    );
  }
}
