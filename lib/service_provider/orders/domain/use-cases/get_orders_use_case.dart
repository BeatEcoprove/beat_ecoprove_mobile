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
  final OrderService _orderService;

  GetOrdersUseCase(this._orderService);

  @override
  Future<List<OrderItem>> handle(request) async {
    List<OrderResult> ordersResult;
    List<OrderItem> orders = [];
    String filters = '';

    if (request.params.isNotEmpty) {
      filters = _prepareRequest(request.params);
    }

    try {
      ordersResult = await _orderService.getOrders(
        filters,
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
    }

    for (var order in ordersResult) {
      if (order is OrderClothResult) {
        var orderCard = OrderItem(
          orderId: order.orderId,
          ownerId: order.ownerId,
          username: order.username,
          avatarPicture: order.avatarPicture,
          card: CardItem(
            id: order.cloth.id,
            clothState: order.cloth.clothState,
            title: order.cloth.name,
            brand: order.cloth.brand,
            color: Color(
              int.parse(
                order.cloth.color,
                radix: 16,
              ),
            ),
            ecoScore: order.cloth.ecoScore,
            size: order.cloth.size.toUpperCase(),
            child: order.cloth.clothAvatar,
            hasProfile: order.cloth.otherProfileAvatar != null
                ? ServerImage(order.cloth.otherProfileAvatar!)
                : null,
          ),
          services: order.services.map((e) => e.name).toList(),
        );

        orders.add(orderCard);
      }

      if (order is OrderBucketResult) {
        var orderCard = OrderItem(
          orderId: (order).orderId,
          ownerId: order.ownerId,
          username: order.username,
          avatarPicture: order.avatarPicture,
          card: CardItem(
            id: order.bucket.id,
            title: order.bucket.name,
            child: order.bucket.associatedCloth.map((item) {
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
          ),
          services: order.services.map((e) => e.name).toList(),
        );

        orders.add(orderCard);
      }
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

    var index = endPoint.lastIndexOf('&');

    return endPoint.substring(0, index);
  }
}
