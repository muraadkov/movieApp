import 'package:flutter/material.dart';

class Movie {
  final int id;
  final String title, posterPath, releaseDate;
  final double voteAverage;

  Movie({required this.id, required this.title, required this.releaseDate, required this.posterPath,
    required this.voteAverage});

  Movie.fromJson(Map<String, dynamic> json):
        id = json["id"],
        title = json["title"],
        posterPath = json["poster_path"],
        voteAverage = json["vote_average"].toDouble(),
        releaseDate = json["release_date"];
}