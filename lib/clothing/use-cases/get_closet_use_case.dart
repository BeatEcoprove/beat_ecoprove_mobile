import 'package:beat_ecoprove/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/clothing/services/clothing_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:flutter/material.dart';

class GetClosetUseCase implements UseCase<String, Future<List<CardItem>>> {
  final ClothingService _clothingService;

  GetClosetUseCase(this._clothingService);

  @override
  Future<List<CardItem>> handle(String profileId) async {
    ClosetResult closetResult;
    List<CardItem> closet = [];

    try {
      closetResult = await _clothingService.getCloset(profileId);
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }

//TODO: change
    for (var cloth in closetResult.cloths) {
      var card = CardItem(
        title: cloth.name,
        brand: cloth.brand,
        color: const Color(0xFFFFFFFF),
        ecoScore: cloth.ecoScore,
        size: cloth.size,
        child: cloth.clothAvatar,
      );

      closet.add(card);
    }

    for (var bucket in closetResult.buckets) {
      var card = CardItem(
        title: bucket.name,
        child: bucket.associatedCloth.map((item) {
          return CardItem(
            title: item.name,
            brand: item.brand,
            color: const Color(0xFFFFFFFF),
            ecoScore: item.ecoScore,
            size: item.size,
            child: item.clothAvatar,
          );
        }).toList(),
      );

      closet.add(card);
    }

    return closet;
  }
}
