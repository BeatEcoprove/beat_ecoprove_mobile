import 'package:async/async.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/worker_header/worker_can_edit_privilegies_header.dart';
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

  List<OptionItem> _options(String workerId) {
    return [
      OptionItem(
        name: "Remover",
        action: () async => await viewModel.removeWorker(
          args.storeId,
          workerId,
        ),
      ),
    ];
  }

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
                                        child: viewModel.hasAuthorization()
                                            ? CompactListItemRoot(
                                                items: [
                                                  WorkerCanEditPrivilegiesHeader(
                                                      title: worker.name,
                                                      subTitle: worker.email,
                                                      dropOptions:
                                                          viewModel.types,
                                                      dropOptionsValue:
                                                          worker.type.text,
                                                      dropOptionsSet: (value) {
                                                        viewModel.setValue(
                                                            FormFieldValues
                                                                .code,
                                                            value);
                                                        viewModel
                                                            .changeWorkerType(
                                                          args.storeId,
                                                          worker.id,
                                                          viewModel
                                                              .getValue(
                                                                  FormFieldValues
                                                                      .code)
                                                              .value,
                                                        );
                                                      }),
                                                  WithOptionsFooter(
                                                    options:
                                                        _options(worker.id),
                                                  )
                                                ],
                                              )
                                            : CompactListItemRoot(
                                                items: [
                                                  WorkerWithTypeHeader(
                                                    title: worker.name,
                                                    subTitle: worker.email,
                                                    workerType: worker
                                                            .type.value[0]
                                                            .toUpperCase() +
                                                        worker.type.value
                                                            .substring(1),
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
            if (viewModel.hasAuthorization())
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
                  onPressed: () async => await viewModel.addWorker(args),
                ),
              ),
          ],
        ),
        type: AppBackgrounds.members,
      ),
    );
  }
}
