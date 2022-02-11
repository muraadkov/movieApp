import 'package:flutter/material.dart';
import 'package:movie_application/models/MovieDetails.dart';

class MovieDetailsResponse {
  final MovieDetails movieDetails;

  MovieDetailsResponse({required this.movieDetails});

  MovieDetailsResponse.fromJson(Map<String, dynamic> json) :
        movieDetails = MovieDetails.fromJson(json);
}