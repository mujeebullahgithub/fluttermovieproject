import 'package:cowlar_project/backend/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../models/movie_video_model.dart';

class MovieVideoScreen extends StatelessWidget {
  const MovieVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)?.settings.arguments as String;
    return VideoScreen(movieId: movieId);
  }
}

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key, required this.movieId}) : super(key: key);
  final String movieId;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Stream<MovieVideoModel> moviekeys;
  @override
  void initState() {
    super.initState();
    String movie_id = widget.movieId;
    Repository repo = Repository();
    moviekeys = repo.loadMovieVideo(movie_id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieVideoModel>(
        stream: moviekeys,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data!;
            return YoutubeVideo(
              movieKey: result.resultsList[0].movieKey,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({Key? key, required this.movieKey}) : super(key: key);
  final String movieKey;

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieKey,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        // onEnded: (data) {
        // },
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: player),
      ),
    );
  }
}
