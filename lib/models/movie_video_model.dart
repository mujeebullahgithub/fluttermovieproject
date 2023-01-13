class MovieVideoModel {
  String id;
  List<MovieVideoModelResult> resultsList;

  MovieVideoModel(this.resultsList, this.id);

  MovieVideoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        resultsList = List<dynamic>.from(json['results'])
            .where((element) => element['type'] == 'Trailer')
            .map((i) => MovieVideoModelResult.fromJson(i))
            .toList();
}

class MovieVideoModelResult {
  final String movieKey;

  MovieVideoModelResult(this.movieKey);

  MovieVideoModelResult.fromJson(Map<String, dynamic> json)
      : movieKey = json['key'];
}
