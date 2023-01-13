class MoviesModel {
  List<MoviesModelResults> resultsList;

  MoviesModel(this.resultsList);

  MoviesModel.fromJson(Map<String, dynamic> json)
      : resultsList = List<dynamic>.from(json['results'])
            .where((element) =>
                element['original_title'] != null &&
                element['backdrop_path'] != null &&
                element['id'] != null)
            .map((i) => MoviesModelResults.fromJson(i))
            // .map((i) => Temp.changer(i))
            .toList();
}

class MoviesModelResults {
  final String name;
  final String imageLink;
  final String id;

  MoviesModelResults(this.name, this.imageLink, this.id);

  MoviesModelResults.fromJson(Map<String, dynamic> json)
      : name = json['original_title'],
        id = json['id'].toString(),
        imageLink = json['backdrop_path'];
}
