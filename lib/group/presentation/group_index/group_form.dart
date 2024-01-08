import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupForm extends StatelessWidget {
  const GroupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<GroupViewModel>(context);
    final goRouter = GoRouter.of(context);

    return Scaffold(
      appBar: StandardHeader(
        title: "Grupos",
        sustainablePoints: viewModel.user.sustainablePoints,
        hasSustainablePoints: false,
        hasSettings: false,
        hasSearchBar: true,
      ),
      body: AppBackground(
        content: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Meus Grupos",
                            style: AppText.titleToScrollSection,
                            overflow: TextOverflow.ellipsis,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.add_rounded,
                              color: AppColor.widgetSecondary,
                            ),
                            onTap: () => goRouter.push('/create'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () => goRouter.push("/chat"),
                        child: CompactListItem.group(
                          isCircular: true,
                          widget: const SvgImage(
                            width: 66,
                            height: 66,
                            path: "assets/points/eco_score_points_icon.svg",
                          ),
                          title: "Grupo S",
                          subTitle: "3 membros",
                          state: "Privado",
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      const Line(
                        width: 200,
                        color: AppColor.separatedLine,
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Grupos Globais",
                            style: AppText.titleToScrollSection,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CompactListItem.group(
                        isCircular: true,
                        widget: const SvgImage(
                          width: 66,
                          height: 66,
                          path: "assets/points/eco_score_points_icon.svg",
                        ),
                        title: "Grupo L",
                        subTitle: "700 membros",
                        state: "Público",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        type: AppBackgrounds.group,
      ),
    );
  }
}
