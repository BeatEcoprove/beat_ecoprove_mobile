import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class FeedbackName {
  final String name;

  FeedbackName._(this.name);

  factory FeedbackName.create(String feedbackName) {
    if (feedbackName.isEmpty) {
      throw DomainException("Por favor introduza um nome ao feedback!");
    }

    return FeedbackName._(feedbackName);
  }

  @override
  String toString() {
    return name;
  }
}
