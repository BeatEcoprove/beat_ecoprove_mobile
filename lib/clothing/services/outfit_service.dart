import 'dart:io';

import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class OutfitService {
  final HttpAuthClient _httpClient;

  OutfitService(this._httpClient);

  Future markClothAsInUse(List<String> idsCloth) async {
    var result;

    for (var idCloth in idsCloth) {
      try {
        result = await _httpClient.makeRequestJson(
            method: HttpMethods.put,
            path: "profiles/closet/cloth/${idCloth}/use",
            expectedCode: 200);
      } on Exception catch (e) {
        print(e);
      }
    }

    return result;
  }

  Future unMarkClothAsInUse(List<String> idsCloth) async {
    for (var idCloth in idsCloth) {
      return await _httpClient.makeRequestJson(
          method: HttpMethods.put,
          path: "profiles/closet/cloth/${idCloth}/unUse",
          expectedCode: 200);
    }
  }
}
