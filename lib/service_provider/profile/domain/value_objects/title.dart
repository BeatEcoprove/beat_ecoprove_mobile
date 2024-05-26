import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class TitleInput {
  final String title;

  TitleInput._(this.title);

  factory TitleInput.create(String title) {
    if (title.isEmpty) {
      throw DomainException("Por favor introduza um título");
    }

    return TitleInput._(title);
  }

  @override
  String toString() {
    return title;
  }
}
