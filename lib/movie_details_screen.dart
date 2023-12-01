import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mundiales/model/movie_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? args;
  const MovieDetailsScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieVideo> futureMovieVideo;

  Future<MovieVideo> fetchVideo() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.args!['id']}/videos?api_key=af1b76109560756a2450b61eff16e738'));
    if (response.statusCode == 200) {
      return MovieVideo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load video');
    }
  }

  Widget getImageWidget() {
    if (widget.args!['frontPoster'] != null) {
      return CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/original${widget.args!['frontPoster']}',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error));
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    futureMovieVideo = fetchVideo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureMovieVideo,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data?.key == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('')),
            body: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: ListView(
                  children: [
                    Text(
                      widget.args!['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: getImageWidget()),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          widget.args!['overview'],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )),
          );
        }
        YoutubePlayerController controller = YoutubePlayerController(
          initialVideoId: snapshot.data!.key!,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
          ),
        );
        return YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
          ),
          builder: (context, player) {
            return Scaffold(
                appBar: AppBar(title: const Text('')),
                body: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                    child: ListView(
                      children: [
                        Text(
                          widget.args!['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: getImageWidget()),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              widget.args!['overview'],
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        player
                      ],
                    )));
          },
        );
      },
    );
  }
}
