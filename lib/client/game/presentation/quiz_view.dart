import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/game/presentation/quiz_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';

import 'package:flutter/material.dart';

class QuizView extends LinearView<QuizViewModel> {
  const QuizView({super.key, required super.viewModel});

  @override
  Widget build(BuildContext context, QuizViewModel viewModel) {
    if (viewModel.alreadyDoneToday) {
      return _buildAlreadyDone(context, viewModel);
    }

    if (viewModel.completed) {
      return _buildResult(context, viewModel);
    }

    return _buildQuiz(context, viewModel);
  }

  Widget _buildAlreadyDone(BuildContext context, QuizViewModel viewModel) {
    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.trade,
        content: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Circle(
                  color: AppColor.lightGreen,
                  strokeWidth: 7,
                  height: 160,
                  child: Icon(
                    Icons.check_rounded,
                    color: AppColor.lightGreen,
                    size: 100,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      LocaleContext.get().game_quiz_already_done,
                      style: AppText.header,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      LocaleContext.get().game_quiz_come_back_tomorrow,
                      style: AppText.subHeader,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                FormattedButton(
                  content: LocaleContext.get().game_quiz_go_back,
                  textColor: Colors.white,
                  onPress: viewModel.goBack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context, QuizViewModel viewModel) {
    final coins = viewModel.correctAnswers * QuizViewModel.rewardCoins;

    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.closet,
        content: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events_outlined,
                    size: 92, color: Colors.amber),
                const SizedBox(height: 24),
                Text(
                  LocaleContext.get().game_quiz_completed,
                  style: AppText.header,
                ),
                const SizedBox(height: 12),
                Text(
                  "${viewModel.correctAnswers}/${viewModel.totalQuestions} ${LocaleContext.get().game_quiz_correct_answers}",
                  style: AppText.subHeader,
                ),
                const SizedBox(height: 32),
                Points.ecoCoins(
                  points: coins,
                ),
                const SizedBox(height: 40),
                FormattedButton(
                  content: LocaleContext.get().game_quiz_go_back,
                  textColor: Colors.white,
                  onPress: viewModel.goBack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuiz(BuildContext context, QuizViewModel viewModel) {
    final question = viewModel.currentQuestion;

    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.createGroup,
        content: SafeArea(
          child: GoBack(
            posTop: 18,
            posLeft: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 86),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        "${viewModel.currentIndex + 1}/${viewModel.totalQuestions}",
                        style: AppText.smallSubHeader,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: (viewModel.currentIndex + 1) /
                                viewModel.totalQuestions,
                            backgroundColor:
                                AppColor.separatedLine.withOpacity(0.4),
                            color: AppColor.lightGreen,
                            minHeight: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: AppText.titleToScrollSection,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 26),
                        ...List.generate(question.options.length, (i) {
                          return _OptionTile(
                            label: question.options[i],
                            index: i,
                            selected: viewModel.selectedOption,
                            correctIndex: question.correctIndex,
                            answered: viewModel.answered,
                            onTap: () => viewModel.selectOption(i),
                          );
                        }),
                        if (viewModel.answered) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              question.explanation,
                              style: AppText.smallHeader,
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                if (viewModel.answered)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormattedButton(
                          content: viewModel.isLastQuestion
                              ? LocaleContext.get().game_quiz_result
                              : LocaleContext.get().game_quiz_next,
                          textColor: Colors.white,
                          onPress: viewModel.next,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final int index;
  final int? selected;
  final int correctIndex;
  final bool answered;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.index,
    required this.selected,
    required this.correctIndex,
    required this.answered,
    required this.onTap,
  });

  String get _letter => String.fromCharCode(65 + index);

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = index == correctIndex;
    final bool isSelected = index == selected;

    Color borderColor = AppColor.widgetSecondary;
    Color bgColor = Colors.white.withOpacity(0.08);
    Color letterBg = AppColor.widgetSecondary;
    Color letterColor = Colors.white;

    if (answered) {
      if (isCorrect) {
        borderColor = AppColor.lightGreen;
        bgColor = AppColor.lightGreen.withOpacity(0.15);
        letterBg = AppColor.lightGreen;
        letterColor = Colors.white;
      } else if (isSelected) {
        borderColor = Colors.redAccent;
        bgColor = Colors.redAccent.withOpacity(0.15);
        letterBg = Colors.redAccent;
        letterColor = Colors.white;
      }
    } else if (isSelected) {
      borderColor = AppColor.widgetSecondary;
      bgColor = AppColor.widgetSecondary.withOpacity(0.15);
      letterBg = AppColor.widgetSecondary;
      letterColor = Colors.white;
    }

    return GestureDetector(
      onTap: answered ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColor.widgetBackground.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: letterBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _letter,
                  style: AppText.smallHeader?.copyWith(
                    color: letterColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: AppText.smallHeader),
            ),
            if (answered && (isCorrect || isSelected))
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: isCorrect ? AppColor.lightGreen : Colors.redAccent,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
