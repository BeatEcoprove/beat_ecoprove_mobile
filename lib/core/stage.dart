import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/stage_viewmodel.dart';
import 'package:beat_ecoprove/core/view.dart';

abstract class Stage<TStageViewModel extends StageViewModel>
    extends LinearView<TStageViewModel> {
  final SignInController controller;

  const Stage({
    super.key,
    required super.viewModel,
    required this.controller,
  });

  void handleNext({Map<FormFieldValues, FormFieldModel>? data}) {
    controller.nextPage(data ?? viewModel.fields);
  }

  void handlePrevious({Map<FormFieldValues, FormFieldModel>? data}) {
    controller.previousPage(data: data ?? viewModel.fields);
    controller.setStages();
  }
}
