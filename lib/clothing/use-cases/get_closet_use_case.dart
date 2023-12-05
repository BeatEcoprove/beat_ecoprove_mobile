import 'package:beat_ecoprove/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:flutter/material.dart';

class GetClosetUseCase implements UseCaseAction<Future<List<CardItem>>> {
  final ClosetService _clothingService;

  GetClosetUseCase(this._clothingService);

  @override
  Future<List<CardItem>> handle() async {
    ClosetResult closetResult;
    List<CardItem> closet = [];

    try {
      closetResult = await _clothingService.getCloset();
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }

    for (var cloth in closetResult.cloths) {
      var card = CardItem(
        id: cloth.id,
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

      closet.add(card);
    }

    return closet;
  }
}
