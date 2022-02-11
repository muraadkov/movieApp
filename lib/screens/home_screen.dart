import 'package:flutter/material.dart';
import 'package:movie_application/bloc/movies_bloc.dart';
import 'package:movie_application/models/Movie.dart';
import 'package:movie_application/screens/movie_details_screen.dart';
import 'package:movie_application/widgets/error_widget.dart';
import 'package:movie_application/widgets/loading_widget.dart';
import 'package:movie_application/widgets/movie_card.dart';
import 'package:movie_application/widgets/movie_details.dart';
import 'package:movie_application/widgets/popular_movies.dart';
import 'package:movie_application/widgets/rating_bar.dart';

bool byName = true;
bool byRating = false;
bool byDate = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? dropDownValue = "По названию";
  Container androidDropdown() {

    // List of items in our dropdown menu
    var items = [
      'По названию',
      'По дате выхода',
      'По рейтингу',
    ];
    return Container(
      height: 35.0,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        value: dropDownValue,
        items: items.map((e) => DropdownMenuItem(
          value: e,
          child: Text(
            e,
            style: const TextStyle(
                color: Colors.black
            ),
          ),
        )).toList(),
          onChanged: (newValue) {
            setState(() {
              if (newValue == "По названию") {
                dropDownValue = newValue;
                byName = true;
                byDate = false;
                byRating = false;

              } else if (newValue == "По дате выхода") {
                dropDownValue = newValue;
                byDate = true;
                byName = false;
                byRating = false;
              } else {
                byRating = true;
                byName = false;
                byDate = false;
                dropDownValue = newValue;
              }
            });
        }
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 10;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = ( _screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var cellHeight = 270;
    var _aspectRatio = _width /cellHeight;
    return StreamBuilder(
      stream: moviesBloc.subject.stream,
      builder: (context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return Scaffold(
            backgroundColor: const Color(0xFF15141F),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Фильмы",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        androidDropdown()
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: _aspectRatio,
                            ),
                            itemCount: snapshot.data.movies.length,
                            itemBuilder: (context, index) {
                              if(byName) {
                                snapshot.data.movies.sort((a,b) => a.title.toString().toLowerCase().compareTo(b.title.toString().toLowerCase()));
                              } else if(byDate) {
                                snapshot.data.movies.sort((a,b) => b.releaseDate.toString().compareTo(a.releaseDate.toString()));
                              } else if(byRating) {
                                snapshot.data.movies.sort((a,b) => b.voteAverage.toString().compareTo(a.voteAverage.toString()));
                              }
                              return MovieCard(
                                movie: snapshot.data.movies[index],
                                tapMovie: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(movieId: snapshot.data.movies[index].id),
                                  ),
                                  );
                                },
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
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
      },
    );
  }
}



