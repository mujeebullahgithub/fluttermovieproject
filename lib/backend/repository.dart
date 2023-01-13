import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/individual_movie_model.dart';
import '../models/movie_video_model.dart';
import '../models/movies_model.dart';

class Repository {
  static String apiKey = "ac4fe5ee4945fa4696848e55e538bad7";

  final String getUpcomingMovies =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';
  final String getPopularMovies =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
  final String getSearchMovies =
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=';
  final String getSearchMovieDetail = 'https://api.themoviedb.org/3/movie/';
  final String getMovieVideo = 'https://api.themoviedb.org/3/movie/';

  Stream<MoviesModel> loadUpcomingMovies() async* {
    final response = await http.get(Uri.parse(getUpcomingMovies));
    if (response.statusCode == 200) {
      yield MoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Stream<MoviesModel> loadPopularMovies() async* {
    final response = await http.get(Uri.parse(getPopularMovies));
    if (response.statusCode == 200) {
      yield MoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Stream<MoviesModel> loadSearchMovies(String searchKeyword) async* {
    final response = await http.get(Uri.parse(getSearchMovies + searchKeyword));
    if (response.statusCode == 200) {
      yield MoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Stream<IndividualMovieResult> loadMovieDetail(String movieId) async* {
    final response = await http
        .get(Uri.parse('$getSearchMovieDetail$movieId?api_key=$apiKey'));
    if (response.statusCode == 200) {
      yield IndividualMovieResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Stream<MovieVideoModel> loadMovieVideo(String movieId) async* {
    final response = await http
        .get(Uri.parse('$getMovieVideo$movieId/videos?api_key=$apiKey'));
    if (response.statusCode == 200) {
      yield MovieVideoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
