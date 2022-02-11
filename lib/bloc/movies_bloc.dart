import 'package:movie_application/models/response/movie_response.dart';
import 'package:movie_application/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';

class MoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject();

  getMovies() async {
    MovieResponse response = await _repository.fetchMovies(http.Client());
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesBloc = MoviesBloc();