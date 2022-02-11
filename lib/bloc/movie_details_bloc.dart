import 'package:movie_application/models/response/movie_details_response.dart';
import 'package:movie_application/models/response/movie_response.dart';
import 'package:movie_application/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';

class MovieDetailsBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieDetailsResponse> _subject = BehaviorSubject();

  getMovieDetails(int id) async {
    MovieDetailsResponse response = await _repository.fetchMovieDetails(http.Client(), id);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieDetailsResponse> get subject => _subject;
}

final movieDetailsBloc = MovieDetailsBloc();