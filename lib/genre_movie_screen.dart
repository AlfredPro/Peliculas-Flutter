import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mundiales/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:mundiales/movie_item.dart';

class GenreMovieScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const GenreMovieScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<GenreMovieScreen> createState() => _GenreMovieScreenState();
}

class _GenreMovieScreenState extends State<GenreMovieScreen> {
  late Future<List<Movie>> futureGenreList;

  Future<List<Movie>> fetchList() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=af1b76109560756a2450b61eff16e738&with_genres=${widget.args!['id']}'));
    if (response.statusCode == 200) {
      var movieObjsJson = jsonDecode(response.body)['results'] as List<dynamic>;
      return movieObjsJson
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    futureGenreList = fetchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.args!['title'])),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: FutureBuilder(
            future: futureGenreList,
            builder: (context, listSnap) {
              if (!listSnap.hasData) {
                return Container();
              }
              List<Movie> genresList = listSnap.data ?? [];
              return GridView.builder(
                itemCount: genresList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  //childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return MovieItem(
                      genresList[index].id,
                      genresList[index].title,
                      genresList[index].overview,
                      genresList[index].frontPoster,
                      genresList[index].backPoster);
                },
              );
            },
          ),
        ));
  }
}
