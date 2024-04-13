import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

abstract class ArgumentView<TViewModel extends ViewModel, TArgument>
    extends LinearView<TViewModel> {
  final TArgument args;

  const ArgumentView({
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

  static ArgumentView of<TView extends ArgumentView>(dynamic arguments) {
    return DependencyInjection.locator<TView>(param1: arguments);
  }
}
