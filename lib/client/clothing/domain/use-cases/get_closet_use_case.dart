import 'package:beat_ecoprove/client/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class GetClosetUseCase
    implements UseCase<Map<String, String>, Future<List<CardItem>>> {
  final ClosetService _clothingService;

  GetClosetUseCase(this._clothingService);

  @override
  Future<List<CardItem>> handle(params) async {
    ClosetResult closetResult;
    BucketResult outfitBucketResult;
    List<CardItem> closet = [];
    String filters = '';

    if (params.isNotEmpty) {
      filters = _prepareRequest(params);
    }

    try {
      outfitBucketResult = await _clothingService.getOutfit();
      outfitBucketResult.id = "outfit";
      closetResult = await _clothingService.getCloset(filters);

      closetResult.buckets.add(outfitBucketResult);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }

    for (var cloth in closetResult.cloths) {
      var card = CardItem(
        id: cloth.id,
        clothState: cloth.clothState,
        title: cloth.name,
        brand: cloth.brand,
        color: Color(
          int.parse(
            cloth.color,
            radix: 16,
          ),
        ),
        ecoScore: cloth.ecoScore,
        size: cloth.size.toUpperCase(),
        child: cloth.clothAvatar,
        hasProfile: cloth.otherProfileAvatar != null
            ? ServerImage(cloth.otherProfileAvatar!)
            : null,
      );

      closet.add(card);
    }

    for (var bucket in closetResult.buckets) {
      var card = CardItem(
        id: bucket.id,
        title: bucket.name,
        child: bucket.associatedCloth.map((item) {
          return CardItem(
            id: item.id,
            clothState: item.clothState,
            title: item.name,
            brand: item.brand,
            color: Color(
              int.parse(
                item.color,
                radix: 16,
              ),
            ),
            ecoScore: item.ecoScore,
            size: item.size.toUpperCase(),
            child: item.clothAvatar,
          );
        }).toList(),
      );

      if (bucket.id == outfitBucketResult.id) {
        closet.insert(0, card);
      } else {
        closet.add(card);
      }
    }

    filters = '';
    return closet;
  }

  String _prepareRequest(Map<String, String> params) {
    Set<String> tags = {};
    String endPoint = '&';

    for (var param in params.values) {
      tags.add(param);
    }

    for (var tag in tags) {
      endPoint +=
          '$tag=${params.entries.where((entry) => entry.value.contains(tag)).map((entry) => entry.key).join(',')}';
      endPoint += '&';
    }

    return endPoint;
  }
}
