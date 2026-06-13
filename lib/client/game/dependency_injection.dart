import 'package:beat_ecoprove/client/game/presentation/quiz_view.dart';
import 'package:beat_ecoprove/client/game/presentation/quiz_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension GameInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {}

  void _addViewModels(GetIt locator) {
    locator.registerFactory(
      () => QuizViewModel(
        locator<INavigationManager>(),
      ),
    );
  }

  void _addView(GetIt locator) {
    locator.registerFactory(
      () => QuizView(
        viewModel: locator<QuizViewModel>(),
      ),
    );
  }

  void addGame() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addView(locator);
  }
}
