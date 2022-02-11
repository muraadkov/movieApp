import 'package:flutter/material.dart';
import 'package:movie_application/models/Movie.dart';
import 'package:movie_application/widgets/movie_details.dart';
import 'package:movie_application/widgets/rating_bar.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie, required this.tapMovie}) : super(key: key);
  final Movie movie;
  final VoidCallback tapMovie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapMovie,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
            ),
            fit: BoxFit.fitWidth,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingBar(voteAverage: movie.voteAverage),
            MovieDetailsPopular(movie: movie)
          ],
        ),

      ),
    );
  }
}
