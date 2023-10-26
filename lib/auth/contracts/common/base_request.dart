abstract class BaseJsonRequest {
  Map<String, dynamic> toJson();
}

abstract class BaseMultiPartRequest {
  Map<String, dynamic> toMultiPart();
}
