class MovieVideo {
  final String? key;

  const MovieVideo({required this.key});

  factory MovieVideo.fromJson(Map<String, dynamic> json) {
    var resultsObjJason = json['results'] as List;
    for (var element in resultsObjJason) {
      if (element['site'] == 'YouTube') {
        return MovieVideo(key: element['key']);
      }
    }
    return const MovieVideo(key: null);
  }
}
