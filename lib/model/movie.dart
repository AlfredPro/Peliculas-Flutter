class Movie {
  final int id;
  final String title;
  final String overview;
  final String? frontPoster;
  final String? backPoster;

  const Movie(
      {required this.id,
      required this.title,
      required this.overview,
      this.frontPoster,
      this.backPoster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        frontPoster: json['poster_path'],
        backPoster: json['backdrop_path']);
  }
}
