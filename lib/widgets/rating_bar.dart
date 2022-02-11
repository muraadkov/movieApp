import 'package:flutter/material.dart';
import 'package:movie_application/models/Movie.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    Key? key,
    required this.voteAverage,
  }) : super(key: key);

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.topRight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(7.0),
              child: CircularProgressIndicator(
                backgroundColor: Colors.black54,
                color: Colors.white,
                strokeWidth: 3,
                value: voteAverage / 10,
              ),
            ),
            Text(
              "${voteAverage}",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
    );
  }
}