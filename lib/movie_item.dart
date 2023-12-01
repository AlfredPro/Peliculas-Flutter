import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final int id;
  final String title;
  final String overview;
  final String? frontPoster;
  final String? backPoster;

  const MovieItem(
      this.id, this.title, this.overview, this.frontPoster, this.backPoster,
      {super.key});

  void selectMovie(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/movie-genres/movie',
      arguments: {
        'id': id,
        'title': title,
        'overview': overview,
        'frontPoster': frontPoster
      },
    );
  }

  Widget getImageWidget() {
    if (backPoster != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 3,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original$backPoster',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error))))
        ],
      );
    } else {
      return Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMovie(context),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.7),
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        child: Center(child: getImageWidget()),
      ),
    );
  }
}
