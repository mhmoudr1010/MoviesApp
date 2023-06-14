class Movie {
  int id;
  String title;
  double voteAverage;
  String releaseDate;
  String overview;
  String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
  });

  /*factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
      id: parsedJson['id'] ?? parsedJson['id'],
      title: parsedJson['title'] ?? parsedJson['title'],
      voteAverage:
          parsedJson['vote_average'] * 1.0 ?? parsedJson['vote_average'] * 1.0,
      releaseDate: parsedJson['release_date'] ?? parsedJson['release_date'],
      overview: parsedJson['overview'] ?? parsedJson['overview'],
      posterPath: parsedJson['poster_path'] ?? parsedJson['poster_path'],
    );
  }*/

  Movie.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] ?? parsedJson['id'],
        title = parsedJson['title'] ?? parsedJson['title'],
        voteAverage = parsedJson['vote_average'] * 1.0 ??
            parsedJson['vote_average'] * 1.0,
        releaseDate = parsedJson['release_date'] ?? parsedJson['release_date'],
        overview = parsedJson['overview'] ?? parsedJson['overview'],
        posterPath = parsedJson['poster_path'] ?? parsedJson['poster_path'];
}
