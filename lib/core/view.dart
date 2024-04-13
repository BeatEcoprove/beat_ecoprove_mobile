import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class LinearView<TViewModel extends ViewModel> extends StatefulWidget {
  final TViewModel viewModel;

  static LinearView of<T extends LinearView>() {
    return DependencyInjection.locator<T>();
  }

  const LinearView({super.key, required this.viewModel});

  void init(TViewModel viewModel) {}
  void afterClone(TViewModel update) {}
  Widget build(BuildContext context, TViewModel viewModel);

  @override
  State<LinearView> createState() => _ViewState<TViewModel>();
}

class _ViewState<TViewModel extends ViewModel>
    extends State<LinearView<TViewModel>> {
  @override
  void initState() {
    widget.init(widget.viewModel);
    widget.viewModel.initSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    if (viewModel is Clone) {
      viewModel = (viewModel as Clone).clone();

      widget.afterClone(viewModel);
      viewModel.initSync();
    }

    return ChangeNotifierProvider<TViewModel>(
      create: (context) => viewModel,
      child: Consumer<TViewModel>(
        builder: (context, value, _) => widget.build(context, value),
      ),
    );
  }
}
