import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoBucketView extends StatefulWidget {
  final String index;
  final CardItem card;

  const InfoBucketView({
    super.key,
    required this.card,
    required this.index,
  });

  @override
  State<InfoBucketView> createState() => _InfoBucketViewState();
}

class _InfoBucketViewState extends State<InfoBucketView> {
  late List<int> passedServices = [0];
  final List<String> selectedCardItems = [];

  Widget renderCards() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardList(
              clothesItems: widget.card.child,
              //Não fazem nada
              onSelectionChanged: (cards) => (cards),
              onSelectionToDelete: (cards) => (cards),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: Stack(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 18,
                    left: 18,
                    child: CircularButton(
                      onPress: () {
                        setState(() {
                          goBack(goRouter);
                        });
                      },
                      height: 46,
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColor.widgetSecondary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 120,
                      left: 36,
                      right: 36,
                      bottom: 16,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: renderCards(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        //TODO: Change background
        type: AppBackgrounds.completed,
      ),
    );
  }

  void goBack(GoRouter goRouter) {
    passedServices.length == 1 ? goRouter.go('/') : passedServices.removeLast();
  }
}
