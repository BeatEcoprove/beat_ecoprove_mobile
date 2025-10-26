abstract class BaseJsonRequest {
  Map<String, dynamic> toJson();
}

abstract class BaseMultiPartRequest {
  Map<String, dynamic> toMultiPart();
}

abstract class BaseFormUrlEncodedRequest {
  Map<String, String> toFormUrlEncoded();
}
