import 'package:beat_ecoprove/client/game/data/quiz_questions.dart';
import 'package:beat_ecoprove/client/game/domain/quiz_question.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';

class QuizViewModel extends FormViewModel {
  final INavigationManager _navigationRouter;

  static const _quizDateKey = 'quiz_last_date';
  static const questionsPerDay = 5;
  static const rewardCoins = 10;

  late List<QuizQuestion> _todayQuestions;
  int _currentIndex = 0;
  int? _selectedOption;
  bool _answered = false;
  int _correctAnswers = 0;
  bool _completed = false;
  bool _alreadyDoneToday = false;

  QuizViewModel(this._navigationRouter) {
    _init();
  }

  bool get alreadyDoneToday => _alreadyDoneToday;
  bool get completed => _completed;
  bool get answered => _answered;
  int? get selectedOption => _selectedOption;
  int get currentIndex => _currentIndex;
  int get correctAnswers => _correctAnswers;
  int get totalQuestions => questionsPerDay;
  QuizQuestion get currentQuestion => _todayQuestions[_currentIndex];
  bool get isLastQuestion => _currentIndex == questionsPerDay - 1;

  void _init() {
    final today = DateTime.now();
    final lastDate = StorageService.getValueSync<String>(_quizDateKey);
    final todayStr = '${today.year}-${today.month}-${today.day}';

    if (lastDate == todayStr) {
      _alreadyDoneToday = true;
      notifyListeners();
      return;
    }

    final allQuestions = List<QuizQuestion>.from(QuizQuestions.current)
      ..shuffle();
    _todayQuestions = allQuestions.take(questionsPerDay).toList();
  }

  void selectOption(int index) {
    if (_answered) return;
    _selectedOption = index;
    _answered = true;

    if (index == currentQuestion.correctIndex) {
      _correctAnswers++;
    }

    notifyListeners();
  }

  Future<void> next() async {
    if (!_answered) return;

    if (isLastQuestion) {
      await _finishQuiz();
      return;
    }

    _currentIndex++;
    _selectedOption = null;
    _answered = false;
    notifyListeners();
  }

  Future<void> _finishQuiz() async {
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';
    await StorageService.setValue(_quizDateKey, todayStr);

    //TODO: Add server endpoit

    _completed = true;
    notifyListeners();
  }

  void goBack() => _navigationRouter.pop();
}
