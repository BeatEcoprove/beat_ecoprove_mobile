import 'dart:ui';

import 'package:beat_ecoprove/client/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class GetBucketByIdUseCase implements UseCase<String, Future<CardItem>> {
  final ClosetService _closetService;

  GetBucketByIdUseCase(this._closetService);

  @override
  Future<CardItem> handle(request) async {
    BucketResult bucketResult;

    try {
      bucketResult = await _closetService.getBucket(request);
    } catch (e) {
      rethrow;
    }

    return CardItem(
      id: bucketResult.id,
      title: bucketResult.name,
      child: bucketResult.associatedCloth.map((item) {
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
  }
}
