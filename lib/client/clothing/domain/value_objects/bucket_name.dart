import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class BucketName {
  final String name;

  BucketName._(this.name);

  factory BucketName.create(String bucketName) {
    if (bucketName.isEmpty) {
      throw DomainException(
          LocaleContext.get().client_clothing_domain_bucket_name_empty);
    }

    return BucketName._(bucketName);
  }

  @override
  String toString() {
    return name;
  }
}
