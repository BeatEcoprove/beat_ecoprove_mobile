import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';

class ListDetailsView
    extends ArgumentView<ListDetailsViewModel, ListDetailsViewParams> {
  const ListDetailsView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, ListDetailsViewModel viewModel) {
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
                        DefaultFormattedTextField(
                          hintText: "Pesquisar",
                          leftIcon: const Icon(Icons.search_rounded),
                          onChange: (search) => viewModel.setSearch(search),
                          initialValue:
                              viewModel.getValue(FormFieldValues.search).value,
                          errorMessage:
                              viewModel.getValue(FormFieldValues.search).error,
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        FutureBuilder(
                            future: args.onSearch(
                              viewModel
                                      .getValue(FormFieldValues.search)
                                      .value ??
                                  '',
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
