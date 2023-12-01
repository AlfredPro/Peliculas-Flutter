import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  final String title;
  final int id;

  const GenreItem(this.id, this.title, {super.key});

  void selectGenre(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/movie-genres',
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectGenre(context),
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
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
