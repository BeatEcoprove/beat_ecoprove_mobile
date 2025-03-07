import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GeoApiService {
  final String _geoApiPtUrl = "https://json.geoapi.pt";

  Future<Map<String, List<String>>> getParishes() async {
    Map<String, List<String>> data = {};

    try {
      var jsonResult = await http.get(
        Uri.parse("$_geoApiPtUrl/municipio/"),
      );

      var parishes = convert.jsonDecode(jsonResult.body);
      data['Portugal'] = List<String>.from(parishes);
    } catch (e) {
      data = {
        LocaleContext.get().core_geo_api_portugal: [
          "Póvoa de Varzim",
          "Vila do Conde",
        ],
        LocaleContext.get().core_geo_api_england: [
          "Manchester",
          "York",
        ],
        LocaleContext.get().core_geo_api_france: [
          "Paris",
        ],
      };
    }

    return data;
  }
}
