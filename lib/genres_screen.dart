import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mundiales/genre_item.dart';
import 'package:mundiales/model/genre_list.dart';
import 'package:mundiales/model/genre.dart';
import 'package:http/http.dart' as http;

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  late Future<GenreList> futureGenreList;

  Future<GenreList> fetchList() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/genre/movie/list?api_key=af1b76109560756a2450b61eff16e738'));
      if (response.statusCode == 200) {
        return GenreList.fromJson(jsonDecode(response.body));
      } else {
        return GenreList.getEmpty();
        //throw Exception('Failed to load genres');
      }
    } catch (_) {
      return GenreList.getEmpty();
      //throw Exception('Failed to load genres');
    }
  }

  @override
  void initState() {
    super.initState();
    futureGenreList = fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Movies')),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: FutureBuilder(
            future: futureGenreList,
            builder: (context, listSnap) {
              if (!listSnap.hasData) {
                return Container();
              }
              List<Genre> genresList = listSnap.data?.list ?? [];
              return GridView.builder(
                itemCount: genresList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return GenreItem(
                      genresList[index].id, genresList[index].name);
                },
              );
            },
          ),
        ));
  }
}
