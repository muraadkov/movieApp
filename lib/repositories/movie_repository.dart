import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_application/models/Movie.dart';
import 'package:movie_application/models/MovieDetails.dart';
import 'package:movie_application/models/response/movie_response.dart';
import 'package:movie_application/models/response/movie_details_response.dart';
import 'dart:io';

final String defaultLocale = Platform.localeName;
class MovieRepository {

  Future<MovieResponse> fetchMovies(http.Client client) async {
      final response = await client.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=2f05ecb893a6f356e596873f1972d65b&language=$defaultLocale"));
      return compute(getMovies, response.body);
  }

  MovieResponse getMovies(String response) {
    final parsed = jsonDecode(response) as Map<String, dynamic> ;
    final movies = MovieResponse.fromJson(parsed);
    return movies;
  }

  Future<MovieDetailsResponse> fetchMovieDetails(http.Client client, int id) async {
    final response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$id?api_key=2f05ecb893a6f356e596873f1972d65b&language=$defaultLocale"));
    return compute(getMovieDetails, response.body);
  }

  MovieDetailsResponse getMovieDetails(String response) {
    final parsed = jsonDecode(response) as Map<String, dynamic>;
    final movie = MovieDetailsResponse.fromJson(parsed);
    return movie;
  }
}


