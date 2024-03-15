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

  Widget build(BuildContext context, TViewModel viewModel);

  @override
  State<IView> createState() => _ViewState<TViewModel>();
}

// ignore: must_be_immutable
abstract class ArgumentedView<TViewModel extends ViewModel, TArgument>
    extends IView<TViewModel> {
  TArgument? args;

  static ArgumentedView of<T extends ArgumentedView, TArgument>(TArgument arg) {
    var view = DependencyInjection.locator<T>();

    view.setArgs(arg);
    return view;
  }

  void setArgs(TArgument newArgs) {
    this.args = newArgs;
  }

  ArgumentedView({super.key, required super.viewModel});
}

class _ViewState<TViewModel extends ViewModel>
    extends State<IView<TViewModel>> {
  @override
  void initState() {
    widget.viewModel.initSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TViewModel>(
      create: (context) => widget.viewModel,
      child: Consumer<TViewModel>(
        builder: (context, value, _) => widget.build(context, value),
      ),
    );
  }
}
