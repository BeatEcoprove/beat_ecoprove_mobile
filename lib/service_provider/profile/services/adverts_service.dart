import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/advert_result.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/register_advert_request.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/remove_advert_request.dart';

class AdvertsService {
  final HttpAuthClient _httpClient;

  AdvertsService(this._httpClient);

  Future<List<AdvertResult>> getActiveAdverts() async {
    List<dynamic> result = await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "adverts",
      expectedCode: 200,
    );

    return result
        .map((advertJson) => AdvertResult.fromJson(advertJson))
        .toList();
  }

  Future removeAdvert(RemoveAdvertRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.delete,
      path: "adverts/${request.advertId}",
      body: request,
      expectedCode: 200,
    );
  }

  Future registerAdvert(RegisterAdvertRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "advert",
      body: request,
      expectedCode: 201,
    );
  }
}
