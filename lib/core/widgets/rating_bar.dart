import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatefulWidget {
  final double rating;
  final bool canRating;

  const RatingBarWidget({
    Key? key,
    required this.rating,
    this.canRating = true,
  }) : super(key: key);

  @override
  State<RatingBarWidget> createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  late double ratingValue;

  @override
  void initState() {
    super.initState();
    ratingValue = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.rating.toString(),
          style: AppText.rating,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 6),
        ),
        RatingBar.builder(
          itemSize: 28,
          initialRating: widget.rating,
          minRating: 0,
          allowHalfRating: true,
          itemCount: 5,
          direction: Axis.horizontal,
          unratedColor: AppColor.widgetSecondary,
          glow: false,
          ignoreGestures: !widget.canRating,
          itemBuilder: (context, _) => const Icon(
            Icons.eco_rounded,
            color: AppColor.primaryColor,
          ),
          onRatingUpdate: (rating) {
            setState(
              () {
                ratingValue = rating;
              },
            );
          },
        ),
      ],
    );
  }
}
