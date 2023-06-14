import 'dart:io';
import 'dart:convert';
import 'movie.dart';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlKey = "api_key=a4cd6a74d875d66c08ff24b82e3fd81b";
  final String urlBase = "https://api.themoviedb.org/3/movie";
  final String urlUpcoming = "/upcoming?";
  final String urlLanguage = "&language=en-US";
  final String urlSearchBase =
      "https://api.themoviedb.org/3/search/movie?api_key=a4cd6a74d875d66c08ff24b82e3fd81b&query=";

  Future<List<Movie>> getUpcoming() async {
    List<Movie>? movies;
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      var jsonResponse = json.decode(result.body);
      print(jsonResponse);
      var moviesMap = jsonResponse["results"] as List;
      movies = moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();
    }
    return movies!;
  }

  Future<List<Movie>> findMovies(String title) async {
    List<Movie>? movies;
    final String query = urlSearchBase + title;
    http.Response result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      var jsonResponse = json.decode(result.body);
      var moviesMap = jsonResponse["results"] as List;
      movies = moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();
    }
    return movies!;
  }
}
