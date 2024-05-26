import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/presentation/list_widget_view/list_widget_params.dart';
import 'package:beat_ecoprove/core/presentation/list_widget_view/list_widget_view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:flutter/material.dart';

class ListWidgetView
    extends ArgumentView<ListWidgetViewModel, ListWidgetViewParams> {
  const ListWidgetView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, ListWidgetViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        type: AppBackgrounds.registerClothBackground1,
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Text(
                          args.title,
                          style: AppText.alternativeHeader,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        FutureBuilder(
                            future: args.getContent(
                              viewModel,
                            ),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.primaryColor,
                                    ),
                                  );
                                default:
                                  if (snapshot.data == null) {
                                    return Text(
                                      args.noResultsText,
                                      textAlign: TextAlign.center,
                                      style: AppText.smallSubHeader,
                                    );
                                  }
                                  return Column(
                                    children: snapshot.data as List<Widget>,
                                  );
                              }
                            })
                      ],
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
