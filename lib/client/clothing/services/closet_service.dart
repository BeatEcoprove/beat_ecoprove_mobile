import 'package:beat_ecoprove/client/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/change_bucket_name_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/brand_result.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/color_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/register_cloth_request.dart';

class ClosetService {
  final HttpAuthClient _httpClient;

  ClosetService(this._httpClient);

  Future<ClosetResult> getCloset(
    String filters, {
    int page = 1,
    int pageSize = 10,
  }) async {
    return ClosetResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/closet?page=$page&pageSize=$pageSize$filters",
      expectedCode: 200,
    ));
  }

  Future<ClosetResult> getBuckets() async {
    return ClosetResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/closet?page=1&pageSize=10",
      expectedCode: 200,
    ));
  }

  Future<BucketResult> getOutfit() async {
    return BucketResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/closet/outfit",
      expectedCode: 200,
    ));
  }

  Future deleteCloth(String clothId) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.delete,
        path: "profiles/closet/cloth/$clothId",
        expectedCode: 201);
  }

  Future deleteBucket(String bucketId) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.delete,
        path: "profiles/closet/bucket/$bucketId",
        expectedCode: 201);
  }

  Future<BucketResult> getBucket(String bucketId) async {
    return BucketResult.fromJson(
      await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "profiles/closet/bucket/$bucketId",
        expectedCode: 201,
      ),
    );
  }

  Future registerCloth(RegisterClothRequest request) async {
    await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "profiles/closet/cloth",
        body: request,
        expectedCode: 201);
  }

  Future registerBucket(RegisterBucketRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "profiles/closet/bucket",
        body: request,
        expectedCode: 201);
  }

  Future changeBucketName(ChangeBucketNameRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.patch,
        path: "profiles/closet/bucket/${request.bucketId}",
        body: request,
        expectedCode: 200);
  }

  Future addClothToBucket(AddClothsBucketRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.put,
        path: "profiles/closet/bucket/${request.bucketId}/add",
        body: request,
        expectedCode: 201);
  }

  Future removeClothFromBucket(RemoveClothFromBucketRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.put,
        path: "profiles/closet/bucket/${request.bucketId}/remove",
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
