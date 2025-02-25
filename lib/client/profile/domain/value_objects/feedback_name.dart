import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class FeedbackName {
  final String name;

  FeedbackName._(this.name);

  factory FeedbackName.create(String feedbackName) {
    if (feedbackName.isEmpty) {
      throw DomainException(
          LocaleContext.get().client_profile_domain_feedback_name);
    }

    return FeedbackName._(feedbackName);
  }

  @override
  String toString() {
    return name;
  }
}
