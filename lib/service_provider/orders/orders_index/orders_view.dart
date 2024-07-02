import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_button.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/horizontal_selector/horizontal_selector_list.dart';
import 'package:beat_ecoprove/core/widgets/order_card/order_header.dart';
import 'package:beat_ecoprove/core/widgets/order_card/order_card_root.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/service_provider/orders/domain/data/filters.dart';
import 'package:beat_ecoprove/service_provider/orders/domain/models/order_item.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrdersView extends LinearView<OrdersViewModel> {
  const OrdersView({
    super.key,
    required super.viewModel,
  });

  SliverAppBar _buildSearchBarAndFilter(OrdersViewModel viewModel) {
    const Radius borderRadius = Radius.circular(5);
    final options = viewModel.getFilters;

    return SliverAppBar(
      toolbarHeight: 76,
      automaticallyImplyLeading: false,
      shadowColor: Colors.transparent,
      backgroundColor: AppColor.widgetBackground,
      pinned: true,
      snap: true,
      floating: true,
      flexibleSpace: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: DefaultFormattedTextField(
                  hintText: "Pesquisar",
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(25),
                  ],
                  leftIcon: const Icon(Icons.search_rounded),
                  onChange: (search) => viewModel.setSearch(search),
                  initialValue:
                      viewModel.getValue(FormFieldValues.search).value,
                  errorMessage:
                      viewModel.getValue(FormFieldValues.search).error,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 6),
              ),
              FilterButton(
                bodyButton: Container(
                  width: 52,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColor.widgetBackground,
                    borderRadius: BorderRadius.all(borderRadius),
                    boxShadow: [AppColor.defaultShadow],
                  ),
                  child: const SvgImage(
                    path: "assets/filter/settings.svg",
                    height: 24,
                    width: 24,
                    color: AppColor.widgetSecondary,
                  ),
                ),
                overlayPaddingBottom: 86,
                overlayPaddingTop: 110,
                contentPaddingTop: 56,
                bodyTop: 0,
                options: options,
                onSelectionChanged: (filter) =>
                    viewModel.changeFilterSelection(filter),
                filterIsSelect: (filter) => viewModel.haveThisFilter(filter),
                selectedFilters: viewModel.allSelectedFilters,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildFilterSelector(OrdersViewModel viewModel) {
    return SliverAppBar(
      toolbarHeight: 46,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.widgetBackground,
      flexibleSpace: SizedBox(
        height: 40,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          children: [
            HorizontalSelectorList(
              list: storePlaces,
              onSelectionChanged: (ids) =>
                  {viewModel.changeHorizontalFiltersSelection(ids)},
              isHorizontalFilterSelected: (filter) =>
                  viewModel.haveThisHorizontalFilter(filter),
            ),
          ],
        ),
      ),
    );
  }

  Padding _renderOrders(List<OrderItem> orders) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: orders
            .map((e) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: OrderCardRoot(
                    items: [
                      OrderHeader(
                        widget:
                            PresentImage(path: ServerImage(e.avatarPicture)),
                        isCircular: true,
                        title: e.username,
                        subTitle: "Pedido ${e.orderId}",
                        cloth: e.clothes.first,
                        services: e.services,
                      ),
                    ],
                    longPress: () => viewModel.goToQRCodePage(),
                  ),
                ))
            .toList(),
      ),
    );
  }

  SliverToBoxAdapter _buildOrdersCardsSection(
      BuildContext context, OrdersViewModel viewModel) {
    return SliverToBoxAdapter(
        child: viewModel.orders.isNotEmpty
            ? _renderOrders(viewModel.orders)
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 36),
                child: const Text(
                  "Não existe nenhum pedido!",
                  style: AppText.subHeader,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ));
  }

  Positioned _addStoreButton() {
    return Positioned(
      bottom: 16,
      right: 26,
      child: FloatingButton(
        color: AppColor.darkGreen,
        dimension: 64,
        icon: const Icon(
          size: 34,
          Icons.add_circle_outline_rounded,
          color: AppColor.widgetBackground,
        ),
        //TODO: READ QRCode TO REGISTER ORDER
        onPressed: () => {},
      ),
    );
  }

  @override
  Widget build(BuildContext context, OrdersViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
        title: "Pedidos",
        sustainablePoints: viewModel.user?.sustainablePoints ?? 0,
      ),
      body: AppBackground(
        content: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _buildSearchBarAndFilter(viewModel),
                //TODO: CHANGE AND PUT ON THE HORIZONTAL FILTERS THE STORE OF THE WORKER IF NOT SERVICE PROVIDER
                // if(viewModel.user.type == "serviceProvider")
                _buildFilterSelector(viewModel),
                _buildOrdersCardsSection(context, viewModel)
              ],
            ),
            _addStoreButton(),
          ],
        ),
        type: AppBackgrounds.clothing,
      ),
    );
  }
}
