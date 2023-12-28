import 'package:beat_ecoprove/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/register_cloth/contracts/brand_result.dart';
import 'package:beat_ecoprove/register_cloth/contracts/color_result.dart';
import 'package:beat_ecoprove/register_cloth/contracts/register_cloth_request.dart';

class ClosetService {
  final HttpAuthClient _httpClient;

  ClosetService(this._httpClient);

  Future<ClosetResult> getCloset() async {
    return ClosetResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.get, path: "profiles/closet", expectedCode: 200));
  }

  Future deleteCloth(String clothId) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.delete,
        path: "profiles/closet/cloth/$clothId",
        expectedCode: 200);
  }

  Future deleteBucket(String bucketId) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.delete,
        path: "profiles/closet/bucket/$bucketId",
        expectedCode: 200);
  }

  Future registerCloth(RegisterClothRequest request) async {
    await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "profiles/closet/cloth",
        body: request,
        expectedCode: 201);
  }

  Future<List<ColorResult>> getAllColors() async {
    var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get, path: "extension/colors/", expectedCode: 200);

    return convertToColorResultList(result);
  }

  Future<List<ColorResult>> convertToColorResultList(
      Map<String, dynamic> json) async {
    List<ColorResult> resultList = (json['colors'] as List)
        .map((item) => ColorResult.fromJson(item))
        .toList();

    return resultList;
  }

  Future<List<BrandResult>> getAllBrands() async {
    var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get, path: "extension/brands/", expectedCode: 200);

    return convertToBrandResultList(result);
  }

  Future<List<BrandResult>> convertToBrandResultList(
      Map<String, dynamic> json) async {
    List<BrandResult> resultList = (json['brands'] as List)
        .map((item) => BrandResult.fromJson(item))
        .toList();

    return resultList;
  }
}
