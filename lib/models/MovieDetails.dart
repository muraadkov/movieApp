import 'package:flutter/material.dart';
import 'package:movie_application/models/Genre.dart';

class MovieDetails {
  final int id, runtime, revenue;
  final String title, backdropPath, releaseDate, posterPath, overview;
  final bool isAdult;
  final double voteAverage;
  final List<Genre> genres;

  MovieDetails({required this.id, required this.title, required this.backdropPath, required this.releaseDate, required this.posterPath,
    required this.isAdult, required this.voteAverage, required this.genres, required this.runtime, required this.revenue, required this.overview});

  MovieDetails.fromJson(Map<String, dynamic> json):
      id = json["id"],
      runtime = json["runtime"],
      revenue = json["revenue"],
      title = json["title"],
      backdropPath = json["backdrop_path"],
      releaseDate = json["release_date"],
      posterPath = json["poster_path"],
      overview = json["overview"],
      isAdult = json["adult"],
      voteAverage = json["vote_average"].toDouble(),
      genres = (json["genres"] as List).map((e) => Genre.fromJson(e)).toList();
}