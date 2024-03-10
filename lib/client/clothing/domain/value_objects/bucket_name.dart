import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class BucketName {
  final String name;

  BucketName._(this.name);

  factory BucketName.create(String bucketName) {
    if (bucketName.isEmpty) {
      throw DomainException("Por favor introduza um nome ao cesto");
    }

    return BucketName._(bucketName);
  }

  @override
  String toString() {
    return name;
  }
}
