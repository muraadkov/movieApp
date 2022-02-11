import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/bloc/movie_details_bloc.dart';
import 'package:movie_application/main.dart';
import 'package:movie_application/models/Genre.dart';
import 'package:movie_application/widgets/adult_bar.dart';
import 'package:movie_application/widgets/error_widget.dart';
import 'package:movie_application/widgets/loading_widget.dart';
import 'package:movie_application/widgets/rating_bar.dart';


class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);
  final int movieId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15141F),
      body: SafeArea(
        child: MovieDetails(id: movieId),
      ),
    );
  }
}


class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key, required this.id}) : super(key: key);
  final int id;


  @override
  _MovieDetails createState() => _MovieDetails();
}

class _MovieDetails extends State<MovieDetails> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailsBloc.getMovieDetails(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: movieDetailsBloc.subject.stream,
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.only(right: 16.0, top: 24.0, left: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500/${snapshot.data.movieDetails.backdropPath}"
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.3
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(CupertinoIcons.back, color: Colors.white,),
                        ),
                        Flexible(
                          child: Text(
                            snapshot.data.movieDetails.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          width: 200.0,
                          height: 270.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                               "https://image.tmdb.org/t/p/w500/${snapshot.data.movieDetails.posterPath}",
                              ),
                               fit: BoxFit.fitWidth,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                snapshot.data.movieDetails.isAdult ? const AdultBar() : const SizedBox(),
                                RatingBar(voteAverage: snapshot.data.movieDetails.voteAverage)
                              ],
                            ),
                            const Text(
                                'Дата выхода:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '${snapshot.data.movieDetails.releaseDate}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              '${(snapshot.data.movieDetails.runtime / 60).floor()} часа ${snapshot.data.movieDetails.runtime - (60 * (snapshot.data.movieDetails.runtime / 60).floor())} минут',
                              style: const  TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'Доход:',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '${snapshot.data.movieDetails.revenue}\$',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],

                        ),

                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'О фильме:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      genresList(snapshot.data.movieDetails.genres),
                      style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '${snapshot.data.movieDetails.overview}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],

                ),
              ),
            );
          }
          else if(snapshot.hasError){
            return const ErrorWidgetMovie();
          }
          else{
            return const LoadingWidget();
          }
        }
    );
  }
}

String genresList(List<Genre> genres) {
  String text = "";
  for(int i = 0 ; i < genres.length; i++ ){
    text += (genres[i].name + ", ");
  }
  return text;
}
