import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterAdvertRequest implements BaseMultiPartRequest {
  final String title;
  final String description;
  final DateTime beginAt;
  final DateTime endAt;
  final XFile picture;
  final String type;
  final int price;

  RegisterAdvertRequest(
    this.title,
    this.description,
    this.beginAt,
    this.endAt,
    this.picture,
    this.type,
    this.price,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'title': title,
      'description': description,
      'beginAt': DateFormat('yyyy-MM-dd').format(beginAt),
      'endAt': DateFormat('yyyy-MM-dd').format(endAt),
      'picture': picture,
      'type': type,
      'price': price,
    };
  }
}

class RegisterAdvertVoucherRequest extends RegisterAdvertRequest {
  final double? priceItem;
  final int? quantityItem;

  RegisterAdvertVoucherRequest(
    super.title,
    super.description,
    super.beginAt,
    super.endAt,
    super.picture,
    super.type,
    super.price,
    this.priceItem,
    this.quantityItem,
  );

  @override
  Map<String, dynamic> toMultiPart() {
    return {
      'title': title,
      'description': description,
      'beginAt': DateFormat('yyyy-MM-dd').format(beginAt),
      'endAt': DateFormat('yyyy-MM-dd').format(endAt),
      'picture': picture,
      'type': type,
      'price': price,
      'priceItem': priceItem,
      'quantityItem': quantityItem,
    };
  }
}
