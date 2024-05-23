import 'dart:ui';

import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/service_provider/orders/contracts/order_result.dart';
import 'package:beat_ecoprove/service_provider/orders/domain/models/order_item.dart';
import 'package:beat_ecoprove/service_provider/orders/services/order_service.dart';

class GetOrdersUseCaseRequest {
  final Map<String, String> params;
  final int page;
  final int pageSize;

  GetOrdersUseCaseRequest(
    this.params, {
    this.page = 1,
    this.pageSize = 50,
  });
}

class GetOrdersUseCase
    implements UseCase<GetOrdersUseCaseRequest, Future<List<OrderItem>>> {
  final OrderService _clothingService;

  GetOrdersUseCase(this._clothingService);

  @override
  Future<List<OrderItem>> handle(request) async {
    List<OrderResult> ordersResult;
    List<CardItem> clothes = [];
    List<OrderItem> orders = [];
    String filters = '';

    if (request.params.isNotEmpty) {
      filters = _prepareRequest(request.params);
    }

    try {
      ordersResult = await _clothingService.getOrders(
        filters,
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
    }

    for (var order in ordersResult) {
      for (var cloth in order.cloths) {
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

      for (var bucket in order.buckets) {
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
        clothes.add(card);
      }

      orders.add(OrderItem(
        id: order.id,
        orderId: order.orderId,
        ownerId: order.ownerId,
        username: order.username,
        avatarPicture: order.avatarPicture,
        clothes: clothes,
        services: order.services,
      ));
      clothes = [];
    }

    filters = '';
    return orders;
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
