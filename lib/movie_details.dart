import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key, required this.movie});

  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    String path;
    double height = MediaQuery.of(context).size.height;

    path = imgPath + movie.posterPath;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: height / 1.5,
              child: Image.network(path),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(movie.overview),
            ),
          ]),
        ),
      ),
    );
  }
}
