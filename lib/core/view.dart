import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class IView<TViewModel extends ViewModel> extends StatefulWidget {
  final TViewModel viewModel;

  static IView of<T extends IView>() {
    return DependencyInjection.locator<T>();
  }

  const IView({super.key, required this.viewModel});

  void init(TViewModel viewModel) {}
  void afterClone(TViewModel update) {}
  Widget build(BuildContext context, TViewModel viewModel);

  @override
  State<IView> createState() => _ViewState<TViewModel>();
}

abstract class ArgumentedView<TViewModel extends ViewModel, TArgument>
    extends IView<TViewModel> {
  final TArgument args;

  const ArgumentedView({
    super.key,
    required super.viewModel,
    required this.args,
  });

  @override
  void init(TViewModel viewModel) {
    viewModel.setArgument(args);
    super.init(viewModel);
  }

  @override
  void afterClone(TViewModel update) {
    update.setArgument(args);
  }

  static ArgumentedView of<TView extends ArgumentedView>(dynamic arguments) {
    return DependencyInjection.locator<TView>(param1: arguments);
  }
}

class _ViewState<TViewModel extends ViewModel>
    extends State<IView<TViewModel>> {
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
