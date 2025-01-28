import 'dart:ui';

import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';

class GetClothByIdUseCase implements UseCase<String, Future<CardItem>> {
  final ClosetService _closetService;

  GetClothByIdUseCase(this._closetService);

  @override
  Future<CardItem> handle(request) async {
    ClothResult clothResult;

    try {
      clothResult = await _closetService.getClothById(request);
    } catch (e) {
      rethrow;
    }

    return CardItem(
      id: clothResult.id,
      clothState: clothResult.clothState,
      title: clothResult.name,
      brand: clothResult.brand,
      color: Color(
        int.parse(
          clothResult.color,
          radix: 16,
        ),
      ),
      ecoScore: clothResult.ecoScore,
      size: clothResult.size.toUpperCase(),
      child: clothResult.clothAvatar,
      hasProfile: clothResult.otherProfileAvatar != null
          ? ServerImage(clothResult.otherProfileAvatar!)
          : null,
    );
  }
}
