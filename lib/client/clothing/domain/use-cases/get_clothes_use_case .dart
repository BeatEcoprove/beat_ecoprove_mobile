import 'package:beat_ecoprove/client/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class GetClothesUseCaseRequest {
  final Map<String, String> params;
  final int page;
  final int pageSize;

  GetClothesUseCaseRequest({
    Map<String, String>? params,
    this.page = 1,
    this.pageSize = 10,
  }) : params = params ?? {};
}

class GetClothesUseCase
    implements UseCase<GetClothesUseCaseRequest, Future<List<CardItem>>> {
  final ClosetService _clothingService;

  GetClothesUseCase(this._clothingService);

  @override
  Future<List<CardItem>> handle(request) async {
    ClosetResult closetResult;
    List<CardItem> clothes = [];
    String filters = '';

    if (request.params.isNotEmpty) {
      filters = _prepareRequest(request.params);
    }

    try {
      closetResult = await _clothingService.getCloset(
        filters,
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
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

      clothes.add(card);
    }

    filters = '';
    return clothes;
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
