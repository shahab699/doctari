import 'package:flutter/material.dart';

class CustomRatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color fillColor;
  final Color emptyColor;
  final int maxStars;

  CustomRatingStars({
    required this.rating,
    this.starSize = 18,
    this.fillColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.maxStars = 5,
  });

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rating.floor();
    List<Widget> starWidgets = [];

    // Add filled stars
    for (int i = 0; i < numberOfStars; i++) {
      starWidgets.add(
        Icon(
          Icons.star,
          size: starSize,
          color: fillColor,
        ),
      );
    }

    // Add half-filled star if applicable
    if (rating - numberOfStars >= 0.5) {
      starWidgets.add(
        Icon(
          Icons.star_half,
          size: starSize,
          color: fillColor,
        ),
      );
      numberOfStars++; // Increment number of stars
    }

    // Add empty stars to complete the max number of stars
    for (int i = numberOfStars; i < maxStars; i++) {
      starWidgets.add(
        Icon(
          Icons.star_border,
          size: starSize,
          color: emptyColor,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starWidgets,
    );
  }
}
