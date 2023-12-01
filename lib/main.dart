import 'package:flutter/material.dart';
import 'package:mundiales/genre_movie_screen.dart';
import 'package:mundiales/genres_screen.dart';
import 'package:mundiales/movie_details_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GenresScreen(),
        '/movie-genres': (context) => GenreMovieScreen(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/movie-genres/movie': (context) => MovieDetailsScreen(
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      },
    );
  }
}
