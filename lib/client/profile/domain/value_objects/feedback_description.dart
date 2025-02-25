import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class FeedbackDescription {
  final String description;

  FeedbackDescription._(this.description);

  factory FeedbackDescription.create(String feedbackDescription) {
    if (feedbackDescription.isEmpty) {
      throw DomainException(
          LocaleContext.get().client_profile_domain_feedback_description);
    }

    return FeedbackDescription._(feedbackDescription);
  }

  @override
  String toString() {
    return description;
  }
}
