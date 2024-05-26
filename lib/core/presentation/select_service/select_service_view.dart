import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_params.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/wrap_services.dart';
import 'package:flutter/material.dart';

class SelectServiceView
    extends ArgumentView<SelectServiceViewModel, ServiceParams> {
  const SelectServiceView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, SelectServiceViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        type: AppBackgrounds.closet,
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 98,
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: args.services.values.first.isNotEmpty
                        ? WrapServices.servicesItems(
                            title: args.services.keys.first,
                            noResultsText: args.noResultsText,
                            services: args.services.values
                                .expand((value) => value)
                                .toList(),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(vertical: 36),
                            child: Text(
                              args.noResultsText,
                              maxLines: 3,
                              style: AppText.subHeader,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
