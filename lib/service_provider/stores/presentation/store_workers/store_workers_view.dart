import 'package:async/async.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/worker_header/worker_with_type_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/store_header.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_view_model.dart';
import 'package:flutter/material.dart';

class StoreWorkersView
    extends ArgumentView<StoreWorkersViewModel, StoreParams> {
  const StoreWorkersView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, StoreWorkersViewModel viewModel) {
    final memo = AsyncMemoizer();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StoreHeader(
        title: args.name,
        numberMembers: args.numberWorkers,
        picture: args.picture,
      ),
      body: AppBackground(
        content: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Funcionários",
                        style: AppText.titleToScrollSection,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FutureBuilder(
                        future: memo.runOnce(() async =>
                            await viewModel.getWorkers(args.storeId)),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              );
                            default:
                              return Column(
                                children: viewModel.workers
                                    .map(
                                      (worker) => Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child:
                                            //TODO: CHANGE
                                            // viewModel.user.type != "regularWorker" ?
                                            //     CompactListItemRoot(
                                            //   items: [
                                            //     WorkerCanEditPrivilegiesHeader(
                                            //       title: worker.name,
                                            //       subTitle: worker.email,
                                            //       dropOptions: viewModel.types,
                                            //       dropOptionsValue: viewModel
                                            //           .getValue(
                                            //               FormFieldValues.code)
                                            //           .value,
                                            //       dropOptionsSet: (value) =>
                                            //           viewModel.setValue(
                                            //               FormFieldValues.code,
                                            //               value),
                                            //     ),
                                            //     WithOptionsFooter(
                                            //       options: viewModel.options,
                                            //     )
                                            //   ],
                                            // ),
                                            // :
                                            CompactListItemRoot(
                                          items: [
                                            WorkerWithTypeHeader(
                                              title: worker.name,
                                              subTitle: worker.email,
                                              //TODO: CHANGE
                                              workerType: "Regular",
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //TODO: CHANGE
            // if(viewModel.user.type != "regularWorker")
            Positioned(
              bottom: 36,
              right: 26,
              child: FloatingButton(
                color: AppColor.darkGreen,
                dimension: 64,
                icon: const Icon(
                  size: 34,
                  Icons.add_circle_outline_rounded,
                  color: AppColor.widgetBackground,
                ),
                onPressed: () async => await viewModel.addWorker(args.storeId),
              ),
            ),
          ],
        ),
        type: AppBackgrounds.members,
      ),
    );
  }
}
