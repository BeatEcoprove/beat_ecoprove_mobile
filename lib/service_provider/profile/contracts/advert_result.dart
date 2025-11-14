import 'package:beat_ecoprove/core/locales/locale_context.dart';

class AdvertResult {
  final String advertId;
  final String advertPicture;
  final String title;
  final DateTime beginIn;
  final DateTime endIn;
  final String contentText;
  final String contentSubText;

  AdvertResult(
    this.advertId,
    this.advertPicture,
    this.title,
    this.beginIn,
    this.endIn,
    this.contentText,
    this.contentSubText,
  );

  factory AdvertResult.fromJson(Map<String, dynamic> json) {
    var type = switch (json['type'] ?? '') {
      'advertisement' =>
        LocaleContext.get().service_provider_profile_profile_advertisement,
      'promotion' =>
        LocaleContext.get().service_provider_profile_profile_promotion,
      'voucher' => LocaleContext.get().service_provider_profile_profile_voucher,
      Object() =>
        LocaleContext.get().service_provider_profile_profile_advertisement,
      null => LocaleContext.get().service_provider_profile_profile_advertisement
    };

    var result = AdvertResult(
      json['id'] ?? '',
      json['picture'] ?? '',
      type,
      DateTime.parse(json['begin_at']),
      DateTime.parse(json['end_at']),
      json['title'] ?? '',
      json['description'] ?? '',
    );

    return result;
  }
}
