
import 'package:flutter/material.dart';
import 'package:flutterlearniti/core/widget/helper.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final Color color;

  const StarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.color = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(starCount, (index) {
        if (index < rating.floor()) {
          return Icon(
            Icons.star,
            color: color,
            size: Helper.getResponsiveWidth(context, width: 16),
          );
        } else if (index < rating) {
          return Icon(
            Icons.star_half,
            color: color,
            size: Helper.getResponsiveWidth(context, width: 16),
          );
        } else {
          return Icon(
            Icons.star_border,
            color: color,
            size: Helper.getResponsiveWidth(context, width: 16),
          );
        }
      }),
    );
  }
}