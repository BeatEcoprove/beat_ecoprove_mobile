import 'package:async/async.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StoreForm extends StatelessWidget {
  const StoreForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<StoreViewModel>(context);
    final goRouter = GoRouter.of(context);
    final memo = AsyncMemoizer();

    return Scaffold(
      appBar: StandardHeader(
        title: "Lojas",
        sustainablePoints: viewModel.user.sustainablePoints,
        hasSettings: false,
      ),
      body: AppBackground(
        content: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FutureBuilder(
                future: memo.runOnce(() async => await viewModel.getStores()),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      );
                    default:
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 26,
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    children: _renderCards(
                                      goRouter,
                                      viewModel.stores,
                                    ),
                                  ),
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
            Positioned(
              bottom: 16,
              right: 26,
              child: FloatingButton(
                color: AppColor.darkGreen,
                dimension: 64,
                icon: const Icon(
                  size: 34,
                  Icons.add_circle_outline_rounded,
                  color: AppColor.widgetBackground,
                ),
                onPressed: () async => await viewModel.createStore(),
              ),
            ),
          ],
        ),
        type: AppBackgrounds.members,
      ),
    );
  }

  List<Widget> _renderCards(GoRouter goRouter, List<Widget> groups) {
    return [];
    // groups
    //     .map(
    //       (e) => Container(
    //         margin: const EdgeInsets.symmetric(
    //           vertical: 4,
    //         ),
    //         child: InkWell(
    //           onTap: () => goRouter.push("/chat", extra: e),
    //           child: CompactListItem.group(
    //             isCircular: true,
    //             widget: ClipRRect(
    //               borderRadius: BorderRadius.circular(100),
    //               child: Image(
    //                 image: ServerImage(e.avatarPicture),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             title: e.name,
    //             subTitle: "${e.membersCount} membros",
    //             state: e.isPublic ? "Público" : "Privado",
    //           ),
    //         ),
    //       ),
    //     )
    //     .toList();
  }
}
