import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CountryCodesService {
  final String _countryApiUrl = "https://countryapi.io/api";

  Future<Map<String, String>> getCountryCodes() async {
    Map<String, String> countryCodes = {};

    try {
      var jsonResult = await http.get(
        Uri.parse("$_countryApiUrl/all"),
        headers: {
          "Authorization": "Bearer ${ServerConfig.countriesApiKey}",
        },
      );

      var result = convert.jsonDecode(jsonResult.body) as Map<String, dynamic>;

      for (var key in result.keys) {
        countryCodes[key] = result[key]['callingCode'];
      }
    } catch (e) {
      countryCodes = const {
        "us": "+1",
        "pt": "+351",
        "br": "+55",
        "es": "+34",
        "fr": "+33",
        "it": "+32",
        "gb": "+31",
      };
    }

    return countryCodes;
  }
}
