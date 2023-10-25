import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/cloths_card_item.dart';
import 'package:beat_ecoprove/core/widgets/filter_button.dart';
import 'package:beat_ecoprove/core/widgets/filter_card_type.dart';
import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:flutter/material.dart';

class ClothingView extends StatefulWidget {
  const ClothingView({super.key});

  @override
  State<ClothingView> createState() => _ClothingViewState();
}

class _ClothingViewState extends State<ClothingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSearchBarAndFilter(),
              _buildFilterSelector(),
              _buildClothsCardsSection(),
            ],
          ),
          const Positioned(
            bottom: 16,
            right: 26,
            child: FloatingButton(
              color: AppColor.darkGreen,
              dimension: 64,
              icon: Icon(
                size: 34,
                Icons.notifications_none_rounded,
                color: AppColor.widgetBackground,
              ),
            ),
          ),
          const Positioned(
            bottom: 78,
            right: 9,
            child: FloatingButton(
              color: AppColor.buttonBackground,
              dimension: 49,
              icon: Icon(
                size: 29,
                Icons.qr_code,
                color: AppColor.widgetBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

SliverAppBar _buildSearchBarAndFilter() {
  return SliverAppBar(
    toolbarHeight: 76, // TODO: Change
    shadowColor: Colors.transparent,
    backgroundColor: AppColor.widgetBackground,
    pinned: true,
    flexibleSpace: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const Row(
          children: [
            Expanded(
              child: FormattedTextField(
                hintText: "Pesquisar",
                leftIcon: Icon(Icons.search_rounded),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 6),
            ),
            FilterButton(),
          ],
        ),
      ),
    ),
  );
}

SliverAppBar _buildFilterSelector() {
  return SliverAppBar(
    toolbarHeight: 46,
    pinned: true,
    backgroundColor: AppColor.widgetBackground,
    flexibleSpace: SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: clothes.length,
        itemBuilder: (BuildContext context, int index) {
          var cloth = clothes[index];
          return _buildFilters(cloth);
        },
      ),
    ),
  );
}

Widget _buildFilters(cloth) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: FilterCardType(
      title: cloth.typeOfCloth,
      isSelected: cloth.isSelected,
    ),
  );
}

SliverToBoxAdapter _buildClothsCardsSection() {
  return SliverToBoxAdapter(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 6,
            children: [
              for (int i = 0; i < clothesItem.length; i++) ...[
                Container(
                  padding: const EdgeInsets.only(
                    right: 6,
                    left: 6,
                  ),
                  child: ClothsCardItem(
                    name: clothesItem[i].name,
                    image: clothesItem[i].image,
                    isOtherProfile: clothesItem[i].isOtherProfile,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
