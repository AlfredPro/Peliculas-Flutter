import 'package:mundiales/model/genre.dart';

class GenreList {
  List<Genre> list;

  GenreList(this.list);

  factory GenreList.fromJson(Map<String, dynamic> json) {
    var genresObjJason = json['genres'] as List;
    List<Genre> tmplist =
        genresObjJason.map((genreJson) => Genre.fromJson(genreJson)).toList();
    return GenreList(tmplist);
  }

  factory GenreList.getEmpty() {
    List<Genre> tmplist = <Genre>[];
    return GenreList(tmplist);
  }
}
