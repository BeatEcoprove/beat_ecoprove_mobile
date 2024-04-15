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
      data = const {
        "Portugal": [
          "Póvoa de Varzim",
          "Vila do Conde",
        ],
        "Inglaterra": [
          "Manchester",
          "York",
        ],
        "França": [
          "Paris",
        ],
      };
    }

    return data;
  }
}
