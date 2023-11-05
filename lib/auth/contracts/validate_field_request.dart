import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class ValidateFieldRequest implements BaseJsonRequest {
  final String fieldName;
  final String value;

  ValidateFieldRequest(this.fieldName, this.value);

  @override
  Map<String, dynamic> toJson() {
    return {"fieldName": fieldName, "value": value};
  }
}
