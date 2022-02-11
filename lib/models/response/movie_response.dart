import 'package:flutter/material.dart';
import 'package:movie_application/models/Movie.dart';

class MovieResponse {
  final List<Movie> movies;

  MovieResponse({required this.movies});

  MovieResponse.fromJson(Map<String, dynamic> json) :
        movies = (json["results"] as List).map((e) => Movie.fromJson(e)).toList();

  int get length {
    return movies.length;
  }

}