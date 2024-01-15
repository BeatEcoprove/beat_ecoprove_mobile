import 'package:async/async.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupForm extends StatelessWidget {
  const GroupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<GroupViewModel>(context);
    final goRouter = GoRouter.of(context);
    final memo = AsyncMemoizer();

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
          child: FutureBuilder(
            future: memo.runOnce(() async => await viewModel.getGroups()),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 26),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              Column(
                                children: _renderCards(goRouter,
                                    viewModel.getAllAuthenticatedUserGroups),
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
                              Column(
                                children: _renderCards(
                                    goRouter, viewModel.getAllPublicGroups),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
        type: AppBackgrounds.group,
      ),
    );
  }

  List<Widget> _renderCards(GoRouter goRouter, List<GroupItem> groups) {
    return groups
        .map(
          (e) => Container(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: InkWell(
              onTap: () => goRouter.push("/chat", extra: e),
              child: CompactListItem.groupWithOptions(
                isCircular: true,
                widget: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: ServerImage(e.avatarPicture),
                    fit: BoxFit.cover,
                  ),
                ),
                title: e.name,
                subTitle: "${e.membersCount} membros",
                state: e.isPublic ? "Público" : "Privado",
                options: [
                  OptionItem(
                    name: 'Sair do Grupo',
                    action: () {},
                  )
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}
