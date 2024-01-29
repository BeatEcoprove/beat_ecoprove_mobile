import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class FeedbackDescription {
  final String description;

  FeedbackDescription._(this.description);

  factory FeedbackDescription.create(String feedbackDescription) {
    if (feedbackDescription.isEmpty) {
      throw DomainException("Por favor introduza uma descrição ao feedback!");
    }

    return FeedbackDescription._(feedbackDescription);
  }

  @override
  String toString() {
    return description;
  }
}
