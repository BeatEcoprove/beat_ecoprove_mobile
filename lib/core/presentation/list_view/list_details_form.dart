import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';

class ListDetailsForm extends StatelessWidget {
  final ListDetailsViewParams params;

  const ListDetailsForm({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    var viewModel = ViewModel.of<ListDetailsViewModel>(context);

    return Scaffold(
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
                          params.title,
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
                            future: params.onSearch(viewModel
                                    .getValue(FormFieldValues.search)
                                    .value ??
                                ''),
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
